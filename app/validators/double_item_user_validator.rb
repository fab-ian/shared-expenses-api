class DoubleItemUserValidator < ActiveModel::Validator
  def validate(record)
    if ItemUser.exists?(item_id: record.item_id, user_id: record.user_id)
      record.errors[:base] << "You can't add the same info twice."
    end
  end
end
