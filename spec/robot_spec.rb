require 'spec_helper'

describe Robot do

	before(:each) do
		@robot = Robot.new
	end

	it 'is placed with valid coordinates' do
		@robot.send(:place, 0, 1)

		result = @robot.send(:placed?)
		expect(result).to eq(true)
	end

	it 'fails placement with invalid coordinates' do
		@robot.send(:place, -1, 0)

		result = @robot.send(:placed?)
		expect(result).to eq(false)
	end

	it 'is oriented with a valid direction' do
		@robot.send(:face, :east)

		expect(@robot.orientation).to eq(:east)
	end

	it 'fails orientation with an invalid direction' do
		@robot.send(:face, :up)

		expect(@robot.orientation).to eq(nil)
	end

	describe 'robot movement' do

		before(:each) do
			@robot.send(:place, 0, 0)
			@robot.send(:face, :north)
		end

		it 'turns left when commanded' do
			@robot.send(:turn_left)

			expect(@robot.orientation).to eq(:west)
		end

		it 'turns right when commanded' do
			@robot.send(:turn_right)

			expect(@robot.orientation).to eq(:east)
		end

		it 'moves in the right direction when commanded' do
			@robot.send(:move)

			expect(@robot.position[:x]).to eq(0)
			expect(@robot.position[:y]).to eq(1)
		end

		it 'prevent movement that would make the robot fall' do
			@robot.send(:turn_left)
			output = @robot.send(:move)

			expect(output).to eq("Invalid movement.")
			expect(@robot.position[:x]).to eq(0)
			expect(@robot.position[:y]).to eq(0)
		end

	end

end