# frozen_string_literal: true

RSpec.describe Ruby2d::Tiled::LDTK do
  describe '.load' do
    let(:world_one) { Ruby2d::Tiled::LDTK.load(File.join(__dir__, '../fixtures/api_features_demo.ldtk')) }
    let(:world_two) { Ruby2d::Tiled::LDTK.load(File.join(__dir__, '../fixtures/2d_platformer.ldtk')) }

    it 'loads levels from LDTK JSON' do
      expect((world_one).levels.size).to eq(4)
      expect((world_two).levels.size).to eq(3)
    end
  end
end