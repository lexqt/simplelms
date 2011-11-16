from django.views.generic import FormView
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from .models import TestFrame, TestFrameXml, CloseType, FRAME_TYPE_CLASSES
from .forms import SingleCloseTypeForm, MultipleCloseTypeForm, StringOpenTypeForm
from django.core.urlresolvers import reverse
from django.shortcuts import get_object_or_404
from django.utils.functional import curry


def my_decorator(cls):
    def wrap(*args, **kw):
        return object.__new__(cls)
    return wrap

def form_class_factory(frame_type, frame):
    if frame_type == 'close':
        if frame.type.is_multiple():
            cls = MultipleCloseTypeForm
        else:
            cls = SingleCloseTypeForm
        return curry(cls, frame.type.variants)
    elif frame_type == 'open':
        t = frame.type.get_type()
        if t == 'string':
            cls = StringOpenTypeForm
        return curry(cls, frame.type.default)
        
    raise Exception('Unsupported frame')



class DebugFrameView(FormView):
    
    template_name = 'debug_frame.html'
    
    def get_form_class(self):
        return form_class_factory(self.frame_db.frame_type, self.frame)
    
    def get_success_url(self):
        return reverse('tests:question_view')

    def get_form(self, form_class):
        return form_class(**self.get_form_kwargs())
    
    def form_valid(self, form):
#        return HttpResponseRedirect(self.get_success_url())
        return self.render_to_response(self.get_context_data(form=form, answered=True))
    
    def form_invalid(self, form):
        return self.render_to_response(self.get_context_data(form=form))
    
    def get_context_data(self, **kwargs):
        context = super(DebugFrameView, self).get_context_data(**kwargs)
        
        answered = kwargs.has_key('answered')
        if answered:
            answer = kwargs['form'].cleaned_data['answer']
            res = self.frame.type.check_answer(answer)
            context['answer_result'] = res
        
        context['answered'] = answered
        context['frame'] = self.frame
        context['frame_index'] = self.frame.frame_index
        return context
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        self.frame_db = get_object_or_404(TestFrame, scheme=kwargs['scheme'], frame_id=kwargs['frame_id'])
        cls = FRAME_TYPE_CLASSES[self.frame_db.frame_type]
        self.frame = TestFrameXml(cls, self.frame_db.get_xml())
        return super(DebugFrameView, self).dispatch(*args, **kwargs)
    