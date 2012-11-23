class KeyFieldsController < ApplicationController
  # GET /key_fields
  # GET /key_fields.json
  def index
    @key_fields = KeyField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @key_fields }
    end
  end

  # GET /key_fields/1
  # GET /key_fields/1.json
  def show
    @key_field = KeyField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @key_field }
    end
  end

  # GET /key_fields/new
  # GET /key_fields/new.json
  def new
    @key_field = KeyField.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @key_field }
    end
  end

  # GET /key_fields/1/edit
  def edit
    @key_field = KeyField.find(params[:id])
  end

  # POST /key_fields
  # POST /key_fields.json
  def create
    @key_field = KeyField.new(params[:key_field])

    respond_to do |format|
      if @key_field.save
        format.html { redirect_to @key_field, notice: 'Key field was successfully created.' }
        format.json { render json: @key_field, status: :created, location: @key_field }
      else
        format.html { render action: "new" }
        format.json { render json: @key_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /key_fields/1
  # PUT /key_fields/1.json
  def update
    @key_field = KeyField.find(params[:id])

    respond_to do |format|
      if @key_field.update_attributes(params[:key_field])
        format.html { redirect_to @key_field, notice: 'Key field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @key_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /key_fields/1
  # DELETE /key_fields/1.json
  def destroy
    @key_field = KeyField.find(params[:id])
    @key_field.destroy

    respond_to do |format|
      format.html { redirect_to key_fields_url }
      format.json { head :no_content }
    end
  end
end
