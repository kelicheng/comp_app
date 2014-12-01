class ComputersController < ApplicationController
  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

  def summary
    @computer = Computer.find_by(user_id: current_user.id)
    # if motherboard_id == nil 

    @motherboard = Motherboard.find_by(id: @computer.motherboard_id)
    @cpu = Cpu.find_by(id: @computer.cpu_id)
    @ram = Ram.find_by(id: @computer.ram_id)
    @gpu = Gpu.find_by(id: @computer.gpu_id)
    @hd = Hd.find_by(id: @computer.hd_id)
    @power = Power.find_by(id: @computer.power_id)
    @sum_watts = (@motherboard.watts + @cpu.watts + @ram.watts + @gpu.watts + @hd.watts)*1.1 
  end

  def new
  	@computer = Computer.new
  end

  def update
    @computer = Computer.find_by(user_id: current_user.id)

    if @computer.update_attributes(computer_params)
      flash[:success] = 'Saved your selection!'
      redirect_to :back
    else
      flash[:danger] = 'We had a problem saving your part'
      redirect_to :back
    end
  end

  def publish #check motherboard and power supply when trying to publish/share 
    @computer = Computer.find_by(user_id: current_user.id)
    @motherboard = Motherboard.find_by(id: @computer.motherboard_id)
    @cpu = Cpu.find_by(id: @computer.cpu_id)
    @ram = Ram.find_by(id: @computer.ram_id)
    @gpu = Gpu.find_by(id: @computer.gpu_id)
    @hd = Hd.find_by(id: @computer.hd_id)
    @power = Power.find_by(id: @computer.power_id)
    @sum_watts = (@motherboard.watts + @cpu.watts + @ram.watts + @gpu.watts + @hd.watts)*1.1 

    if @motherboard.cpu_compad != @cpu.mb_compad
      flash[:danger] = 'Motherboard and CPU do not match.'
      redirect_to :back
    elsif @motherboard.ram_compad != @ram.mb_compad
      flash[:danger] = 'Motherboard and RAM do not match.'
      redirect_to :back
    elsif @motherboard.gpu_compad != @gpu.mb_compad
      flash[:danger] = 'Motherboard and GPU do not match.'
      redirect_to :back
    elsif @motherboard.hd_compad != @hd.mb_compad
      flash[:danger] = 'Motherboard and HD do not match.'
      redirect_to :back
    elsif @power.watts < @sum_watts
      flash[:danger] = 'Power Supply cannot support.'
      redirect_to :back
    else 
      #publish or share this computer here 
    end 

  end 



  def delete_mobo
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.motherboard_id = 1
    if @computer.save
      flash[:success] = "Motherboard deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def delete_cpu
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.cpu_id = 1
    if @computer.save
      flash[:success] = "CPU deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def delete_gpu
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.gpu_id = 1
    if @computer.save
      flash[:success] = "GPU deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def delete_ram
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.ram_id = 1
    if @computer.save
      flash[:success] = "RAM deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def delete_hd
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.hd_id = 1
    if @computer.save
      flash[:success] = "HD deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def delete_power
     @computer = Computer.find_by(user_id: current_user.id)
     # @computer = Computer.find(params[:id])
    @computer.power_id = 1
    if @computer.save
      flash[:success] = "Power Supply deleted."
      redirect_to computers_summary_path

    else
      flash[:danger] = 'Unable to delete.'
      redirect_to computers_summary_path
    end
  end

  def create
  	@computer = current_user.computers.build(computer_params)


  	if @computer.save
      flash[:success] = 'Saved your selection!'
      redirect_to :back

  	else
      flash[:danger] = 'We had a problem saving your part.'
      redirect_to :back
  	end
  end

  

  private

  def computer_params
  	params.require(:computer).permit(:name, :status, :price, :hd_id, :motherboard_id, :ram_id, :gpu_id, :cpu_id, :power_id )
  end
end
