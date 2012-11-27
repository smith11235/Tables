class KeyRecordsController < ApplicationController
  # GET /key_records
  # GET /key_records.json
  def index
    @key_records = KeyRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @key_records }
    end
  end

  # GET /key_records/1
  # GET /key_records/1.json
  def show
    @key_record = KeyRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @key_record }
    end
  end

  # GET /key_records/new
  # GET /key_records/new.json
  def new
    @key_record = KeyRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @key_record }
    end
  end

  # GET /key_records/1/edit
  def edit
    @key_record = KeyRecord.find(params[:id])
  end

  # POST /key_records
  # POST /key_records.json
  def create
    @key_record = KeyRecord.new(params[:key_record])

    respond_to do |format|
      if @key_record.save
        format.html { redirect_to @key_record, notice: 'Key record was successfully created.' }
        format.json { render json: @key_record, status: :created, location: @key_record }
      else
        format.html { render action: "new" }
        format.json { render json: @key_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /key_records/1
  # PUT /key_records/1.json
  def update
    @key_record = KeyRecord.find(params[:id])

    respond_to do |format|
      if @key_record.update_attributes(params[:key_record])
        format.html { redirect_to @key_record, notice: 'Key record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @key_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /key_records/1
  # DELETE /key_records/1.json
  def destroy
    @key_record = KeyRecord.find(params[:id])
    @key_record.destroy

    respond_to do |format|
      format.html { redirect_to key_records_url }
      format.json { head :no_content }
    end
  end
end
