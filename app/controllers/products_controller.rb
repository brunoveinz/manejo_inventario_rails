
class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="my_new_filename.xlsx"'
      }
    end
  end

  # GET /products/1 or /products/1.json
  def show
    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="Detalle del producto.xlsx"'
      }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def new_movement
   @product = Product.find(params[:id])
   @movement = Movement.new
  end

  def create_movement
    @product = Product.find(params[:id]) 
    @movement = Movement.new(movement_params)
    @movement.product_id = @product.id

    if @movement.save
      redirect_to @product, notice: "Movimiento creado correctamente"
    else
      flash[:notice] = "Movimiento no creado correctamente"
      render :new_movement, status: :unprocessable_entity
    end 
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :reference, :description)
    end

    def movement_params
      params.require(:movement).permit(:quantity, :movement_type, :comment)
    end 
end
