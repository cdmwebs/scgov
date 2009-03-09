class RepresentativesController < ApplicationController
  # GET /representatives
  # GET /representatives.xml
  def index
    @representatives = Representative.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @representatives }
    end
  end

  # GET /representatives/1
  # GET /representatives/1.xml
  def show
    @representative = Representative.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @representative }
    end
  end

  # GET /representatives/new
  # GET /representatives/new.xml
  def new
    @representative = Representative.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @representative }
    end
  end

  # GET /representatives/1/edit
  def edit
    @representative = Representative.find(params[:id])
  end

  # POST /representatives
  # POST /representatives.xml
  def create
    @representative = Representative.new(params[:representative])

    respond_to do |format|
      if @representative.save
        flash[:notice] = 'Representative was successfully created.'
        format.html { redirect_to(@representative) }
        format.xml  { render :xml => @representative, :status => :created, :location => @representative }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @representative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /representatives/1
  # PUT /representatives/1.xml
  def update
    @representative = Representative.find(params[:id])

    respond_to do |format|
      if @representative.update_attributes(params[:representative])
        flash[:notice] = 'Representative was successfully updated.'
        format.html { redirect_to(@representative) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @representative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /representatives/1
  # DELETE /representatives/1.xml
  def destroy
    @representative = Representative.find(params[:id])
    @representative.destroy

    respond_to do |format|
      format.html { redirect_to(representatives_url) }
      format.xml  { head :ok }
    end
  end
end
