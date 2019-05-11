# XCAssetsCop

XCAssetsCop is a tool to enforce specific configurations of Xcode assets.

For example, you can ensure every asset inside `Image.xcassets/icons` is rendered as template, has a single scale, and is a pdf file.

### Configs

| Key | Description | Default |
| --- | --- | --- |
| template_rendering_intent | Ensures the assets have a specific template_rendering_intent value. Valid values are: **template**, **original**, **default** | |
| image_scale | Ensures the asset have a specific image_scale value. Valid values are: **single**, **individual**, **individual_and_single** | |
| same_file_and_asset_name | true if you want to make sure the asset name and the file name are the same  | false |
| file_extension | A **string** or **symbol** of the file extension. Ensures the file has a specific extenstion. E.g: `'pdf'` | |
