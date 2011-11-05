from django.views.generic import ListView
from .models import Article

class FrontpageNewsView(ListView):
    
    queryset = Article.objects.filter(published=True).select_related(
        'author').only('title', 'created', 'content', 'author__first_name', 'author__last_name').order_by('-created')[:5]
    context_object_name = 'news_list'
    template_name = 'frontpage_news.html'

    