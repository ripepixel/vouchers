ActiveAdmin.register Article do
  menu :label => "Articles", parent: 'Blog'
  
  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :html_editor
      f.input :article_category
      f.input :author_name
      f.input :published
      f.input :tags
      f.input :image
      f.input :url
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_url
  end
  
end
