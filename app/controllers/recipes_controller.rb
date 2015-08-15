class RecipesController < ApplicationController
    before_action :set_recipe, only:[:edit,:update, :show,:like]
    before_action :require_user, except:[:show, :index] #Require user to be logged in
    before_action :require_same_user, only: [:edit, :update]
    
    def index
        
        # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
        
        #To handle multiple page returns, use paginator gem
        @recipes = Recipe.paginate(page: params[:page], per_page: 4)
    end
    
    def show
        #@recipe = Recipe.find(params[:id])
        
    end
    
    def new
        @recipe = Recipe.new
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        # @recipe.chef = Chef.find(2)
        @recipe.chef = current_user
        
        if @recipe.save
           #saved successfully
           flash[:success] = "Your recipe was created successfully!"
           redirect_to recipes_path
        else
            render :new
        end
        
    end
    
    def edit
        #@recipe = Recipe.find(params[:id])
        
    end
    
    def update
        # @recipe = Recipe.find(params[:id])
        if @recipe.update(recipe_params)
            #Handle successful edit
            flash[:success] = "Your recipe was updated successfully"
            redirect_to recipe_path(@recipe)
        else
           render 'edit' 
        end
    end
    
    def like
    #   @recipe = Recipe.find(params[:id])
       like = Like.create(chef: current_user, recipe: @recipe, like: params[:like])
        if like.valid?
            flash[:success] = "Your selection was successful"
            redirect_to :back
        else
            flash[:danger] = "You can only like / dislike recipe once"    
            redirect_to :back
        end
    end
    
    private
        def recipe_params
            params.require(:recipe).permit(:name,:summary,:description,:picture)
        end
        
        def set_recipe
           @recipe = Recipe.find(params[:id]) 
        end
        
        def require_same_user
            unless @recipe and current_user == @recipe.chef
                flash[:danger] = "You can only edit your own recipes"
                redirect_to root_path
            end
        end
        
    
end