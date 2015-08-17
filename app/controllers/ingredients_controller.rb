class IngredientsController < ApplicationController
  before_action :require_user, only:[:new, :create]
  
  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end

  def new
    @ingredient = Ingredient.new
  
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Your ingredient have been added successfully"
      redirect_to recipes_path
    else
      render 'new'
      
    end
  end

  
  private
  
    def ingredient_params
      params.require(:ingredient).permit(:name)
      
    end
    
end