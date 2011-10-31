from django.contrib import admin



class LinkedStackedInline(admin.options.InlineModelAdmin):
    template = 'admin/edit_inline/stacked_linked.html'
    admin_model_path = None

    def __init__(self, parent_model, admin_site):
        super(LinkedStackedInline, self).__init__(parent_model, admin_site)
        if self.admin_model_path is None:
            self.admin_model_path = self.model.__name__.lower()
