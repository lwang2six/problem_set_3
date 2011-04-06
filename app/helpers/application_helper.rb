module ApplicationHelper
  def submit_or_cancel(form, sname=nil, name='Cancel')
    (form.submit sname) + " or " +
      link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
   end
end
