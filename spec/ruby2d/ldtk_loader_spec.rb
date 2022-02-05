# frozen_string_literal: true

RSpec.describe Ruby2d::Tiled::LDTK do
  describe '.load' do
    let(:two_d_platformer_json) { File.read(File.join(__dir__, '../fixtures/api_features_demo.ldtk')) }
    let(:api_features_demo_json) { File.read(File.join(__dir__, '../fixtures/2d_platformer.ldtk')) }

    it 'loads levels from LDTK JSON' do
      expect(Ruby2d::Tiled::LDTK.load(two_d_platformer_json).levels.size).to eq(4)
      expect(Ruby2d::Tiled::LDTK.load(api_features_demo_json).levels.size).to eq(3)
    end
  end
end