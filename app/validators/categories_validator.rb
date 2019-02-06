class CategoriesValidator < ActiveModel::Validator

  def validate(item)
    category_ids = item.category_ids

    if !category_ids.present? || category_ids.empty?
      item.errors.add(:categories, "Select at least one category.")
    end
  end
end