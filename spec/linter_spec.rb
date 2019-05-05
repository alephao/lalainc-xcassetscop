# frozen_string_literal: true

require 'xcassets_cop/linter'

RSpec.describe XCAssetsCop::Linter, '#get_file_name' do
  it 'should return the file name' do
    contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
    subject = XCAssetsCop::Linter.get_file_name contents_json
    expect(subject).to eq 'image.pdf'
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_template_rendering_intent' do
  context 'with invalid param' do
    it 'should raise an exception' do
      expect { XCAssetsCop::Linter.validate_template_rendering_intent({}, 'invalid') }.to raise_error("'invalid' is not a valid parameter.\nValid parameters: original, template, default")
    end
  end

  context 'with wrong valu' do
    it 'should raise an exception' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      expect { XCAssetsCop::Linter.validate_template_rendering_intent(contents_json, :template) }.to raise_error("Expected image.pdf to be rendered as 'template', got 'original' instead")
    end
  end

  context 'contents with missing key' do
    it 'should fall back to "default"' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      expect(XCAssetsCop::Linter.validate_template_rendering_intent(contents_json, :default)).to be true
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#file_name_matches_asset_name' do
  context 'with asset name different from file name' do
    it 'should raise error' do
      file_path = '/my/path/image_name.imageset/Contents.json'
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      expect { XCAssetsCop::Linter.file_name_matches_asset_name(contents_json, file_path) }.to raise_error("Expected asset name and file name to be the same, got:\nAsset name: image_name\nFile name: image")
    end
  end

  context 'with asset name equal from file name' do
    it 'should return true' do
      file_path = '/my/path/image.imageset/Contents.json'
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      expect(XCAssetsCop::Linter.file_name_matches_asset_name(contents_json, file_path)).to be true
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_image_scale' do
  context 'with invalid param' do
    it 'should raise an exception' do
      expect { XCAssetsCop::Linter.validate_image_scale({}, 'invalid') }.to raise_error("'invalid' is not a valid parameter.\nValid parameters: single, individual, individual_and_single")
    end
  end

  context 'with wrong value' do
    it 'should raise an exception' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      expect { XCAssetsCop::Linter.validate_image_scale(contents_json, :individual) }.to raise_error("Expected image.pdf scale to be 'individual', got 'single' instead")
    end
  end

  context 'with correct value' do
    it 'should return true' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }], 'properties' => { 'template-rendering-intent' => 'original' } }
      expect(XCAssetsCop::Linter.validate_image_scale(contents_json, :single)).to be true
    end
  end
end

RSpec.describe XCAssetsCop::Linter, '#validate_file_extension' do
  context 'with wrong value' do
    it 'should raise an exception' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      expect { XCAssetsCop::Linter.validate_file_extension(contents_json, 'jpg') }.to raise_error('Expected image.pdf type to be jpg, got pdf instead')
    end
  end

  context 'with correct value' do
    it 'should return true' do
      contents_json = { 'images' => [{ 'filename' => 'image.pdf' }] }
      expect(XCAssetsCop::Linter.validate_file_extension(contents_json, 'pdf')).to be true
    end
  end
end
