class ReadmeListener < Redmine::Hook::ViewListener
  def view_projects_show_left(context)
    repository = context[:project].repository
    return '' if repository.nil? or repository.entries.nil?
    repository.fetch_changesets if Setting.autofetch_changesets?
    entry = repository.entries.find{|e| e.name =~ /README((\.).*)/}
    Redmine::WikiFormatting.to_html(Setting.text_formatting, repository.cat(entry.path))
  end
end
