class UnitsController < ApplicationController
  # GET /units
  # GET /units.json
  def index
    unless current_user.can_manage_any_unit
      redirect_to root_path, alert: 'Brak jednostek do zarządzania'
      return
    end

    @units = Unit.find_by_user(current_user)
    @years = Journal.find_all_years

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @units }
    end
  end

  # GET /units/1
  # GET /units/1.json
  def show
    @unit = Unit.find(params[:id])
    authorize! :read, @unit

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit }
    end
  end

  # GET /units/1/edit
  def edit
    @unit = Unit.find(params[:id])
    authorize! :update, @unit
    @groups = Group.find_by_user(current_user, { :can_manage_units => true })
  end

  # PUT /units/1
  # PUT /units/1.json
  def update
    @unit = Unit.find(params[:id])
    authorize! :update, @unit

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        format.html { redirect_to @unit, notice: 'Zmiany zapisane.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /units/new
  # GET /units/new.json
  def new
    @unit = Unit.new
    @groups = Group.find_by_user(current_user, { :can_manage_units => true })
    @unit.groups.push(@groups.first)
    authorize! :create, @unit

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit }
    end
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(params[:unit])
    authorize! :create, @unit

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: 'Jednostka utworzona.' }
        format.json { render json: @unit, status: :created, location: @unit }
      else
        format.html { render action: "new" }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit = Unit.find(params[:id])
    authorize! :destroy, @unit
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :ok }
    end
  end
end
