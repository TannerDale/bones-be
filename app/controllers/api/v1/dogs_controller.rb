class Api::V1::DogsController < ApplicationController
  def index
    render json: DogSerializer.new(paginated_dogs)
  end

  def show
    dog = Dog.find(params[:id])

    render json: DogWithPlaydatesSerializer.new(dog)
  end

  def create
    Dog.create!(dog_params)
  end

  private

  def dog_params
    params.require(:object).permit(:name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description)
  end

  def paginated_dogs
    Dog.exclude_user_dogs(params[:user_id]).limit(per_page).offset(offset)
  end

  def offset
    (page.to_i - 1) * per_page.to_i
  end

  def page
    params[:page]&.to_i&.positive? ? params[:page] : 1
  end

  def per_page
    params[:per_page]&.to_i&.positive? ? params[:per_page] : 20
  end
end
