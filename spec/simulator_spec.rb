require 'spec_helper'

describe Simulator do

	before(:each) do
		@simulator = Simulator.new
		@robot = @simulator.instance_variable_get(:@robot)
	end

	describe 'Before placement' do

		it 'ignores left commands until placement' do
			output = @simulator.send(:execute, 'LEFT')

			expect(output).to eq("Ignoring LEFT command until robot is PLACED.")
		end

		it 'ignores right commands until placement' do
			output = @simulator.send(:execute, 'RIGHT')

			expect(output).to eq("Ignoring RIGHT command until robot is PLACED.")
		end

		it 'ignores move commands until placement' do
			output = @simulator.send(:execute, 'MOVE')

			expect(output).to eq("Ignoring MOVE command until robot is PLACED.")
		end

		it 'ignores report commands until placement' do
			output = @simulator.send(:execute, 'REPORT')

			expect(output).to eq("Ignoring REPORT command until robot is PLACED.")
		end

		it 'ignores place commands with invalid arguments' do
			output = @simulator.send(:execute, 'PLACE 0,0')

			expect(output).to eq("Ignoring PLACE command containing invalid arguments.")
		end

		it 'ignores place commands with invalid coordinates' do
			output = @simulator.send(:execute, 'PLACE 6,0,NORTH')

			expect(output).to eq("Ignoring PLACE command containing invalid arguments.")
		end

		it 'places the robot given valid arguments' do
			@simulator.send(:execute, 'PLACE 1,0,EAST')

			expect(@robot.position[:x]).to eq(1)
			expect(@robot.position[:y]).to eq(0)
			expect(@robot.orientation).to eq(:east)
		end

	end

	describe 'After placement' do

		before(:each) do
			@simulator.send(:execute, 'PLACE 0,0,NORTH')
		end

		it 'lets the robot turn left' do
			expect(@robot).to receive(:turn_left)

			@simulator.send(:execute, 'LEFT')
		end

		it 'lets the robot turn right' do
			expect(@robot).to receive(:turn_right)

			@simulator.send(:execute, 'RIGHT')
		end

		it 'prevents the robot from falling off the table' do
			@simulator.send(:execute, 'LEFT')
			output = @simulator.send(:execute, 'MOVE')

			expect(output).to eq("Invalid movement.")
		end

		it 'lets the robot make valid movements' do
			output = @simulator.send(:execute, 'MOVE')
			position = @robot.send(:position)

			expect(output).to eq(nil)
			expect(position).to eq({ x: 0, y: 1 })
		end

		it 'prints out a report of the robots current position' do
			@simulator.send(:execute, 'MOVE')
			output = @simulator.send(:execute, 'REPORT')

			expect(output).to eq('Output: 0,1,NORTH')
		end

		it 'lets the robot be placed in a new position' do
			@simulator.send(:place, '3,4,WEST')
			output = @simulator.send(:execute, 'REPORT')

			expect(output).to eq('Output: 3,4,WEST')
		end

	end

end