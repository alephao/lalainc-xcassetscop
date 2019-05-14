# frozen_string_literal: true

require 'xcassetscop/linter'

RSpec.describe XCAssetsCop::Linter, '#get_file_name' do
  it 'should return the file name' do
    contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
    subject = XCAssetsCop::Linter.get_file_name contents_json
    expect(subject).to eq 'image.pdf'
  end
end

RSpec.describe XCAssetsCop::Linter, '#file_name_matches_asset_name' do
  context 'with asset name different from file name' do
    it 'should return error message' do
      file_path = '/my/path/image_name.imageset/Contents.json'
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      subject = XCAssetsCop::Linter.file_name_matches_asset_name contents_json, file_path
      expect(subject).to eq ["Expected asset name and file name to be the same, got:\nAsset name: image_name\nFile name: image"]
    end
  end

  context 'with asset name equal from file name' do
    it 'should return no errors' do
      file_path = '/my/path/image.imageset/Contents.json'
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      subject = XCAssetsCop::Linter.file_name_matches_asset_name contents_json, file_path
      expect(subject).to eq []
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_template_rendering_intent' do
  context 'with wrong value' do
    it 'should return error message' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      subject = XCAssetsCop::Linter.validate_template_rendering_intent contents_json, :template
      expect(subject).to eq ["Expected image.pdf to be rendered as 'template', got 'original' instead"]
    end
  end

  context 'contents with missing key' do
    it 'should fall back to "default"' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      subject = XCAssetsCop::Linter.validate_template_rendering_intent contents_json, :default
      expect(subject).to eq []
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_image_scale' do
  context 'with wrong value' do
    it 'should return error message' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      subject = XCAssetsCop::Linter.validate_image_scale contents_json, :individual
      expect(subject).to eq ["Expected image.pdf scale to be 'individual', got 'single' instead"]
    end
  end

  context 'with correct value' do
    it 'should return no error' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      subject = XCAssetsCop::Linter.validate_image_scale contents_json, :single
      expect(subject).to eq []
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_preserves_vector_representation' do
  context 'with false when expecting true' do
    it 'should return error message' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'preserves-vector-representation' => false } }
      subject = XCAssetsCop::Linter.validate_preserves_vector_representation contents_json, true
      expect(subject).to eq ['Expected image.pdf to preserve vector representation']
    end
  end

  context 'with true when expecting false' do
    it 'should return error message' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'preserves-vector-representation' => true } }
      subject = XCAssetsCop::Linter.validate_preserves_vector_representation contents_json, false
      expect(subject).to eq ['Expected image.pdf to NOT preserve vector representation']
    end
  end

  context 'with correct value' do
    it 'should return not return any error' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'preserves-vector-representation' => true } }
      subject = XCAssetsCop::Linter.validate_preserves_vector_representation contents_json, true
      expect(subject).to eq []
    end
  end
end
