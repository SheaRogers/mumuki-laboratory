ActiveAdmin.register Exercise do

  permit_params :author_id,
                :language_id,
                :guide_id,
                :title,
                :layout,
                :description,
                :test,
                :extra_code,
                :hint,
                :corollary,
                :locale

  filter :title
  filter :author
  filter :guide
  filter :language
  filter :locale
  filter :created_at
  filter :updated_at

  index do
    column(:id)
    column(:title)
    column(:language)
    column(:guide)
    column(:layout)
    column(:submissions_count)
    column(:author)
    column(:locale)

    actions
  end
end
