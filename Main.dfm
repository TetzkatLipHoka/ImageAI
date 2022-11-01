object FrmImageAI: TFrmImageAI
  Left = 263
  Top = 245
  AutoScroll = False
  Caption = 'Image AI'
  ClientHeight = 636
  ClientWidth = 1289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnResize = FormResize
  DesignSize = (
    1289
    636)
  PixelsPerInch = 96
  TextHeight = 13
  object splMemo: TSplitter
    Left = 0
    Top = 567
    Width = 1289
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object pnlPreview: TPanel
    Left = 422
    Top = 0
    Width = 867
    Height = 567
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object splPreview: TSplitter
      Left = 420
      Top = 0
      Height = 567
      Align = alRight
      Color = clAqua
      ParentColor = False
      Visible = False
      OnMoved = splPreviewMoved
    end
    object ScrlBoxIn: TScrollBox
      Left = 0
      Top = 0
      Width = 420
      Height = 567
      Align = alClient
      TabOrder = 0
      object imgIn: TImage
        Left = 0
        Top = 0
        Width = 439
        Height = 563
        Proportional = True
        Stretch = True
        OnMouseDown = imgMouseDown
        OnMouseMove = imgMouseMove
        OnMouseUp = imgMouseUp
      end
    end
    object ScrlBoxPreview: TScrollBox
      Left = 423
      Top = 0
      Width = 444
      Height = 567
      Align = alRight
      TabOrder = 1
      Visible = False
      object imgPreview: TImage
        Left = 0
        Top = 0
        Width = 440
        Height = 563
        Proportional = True
        Stretch = True
        OnMouseDown = imgMouseDown
        OnMouseMove = imgMouseMove
        OnMouseUp = imgMouseUp
      end
    end
  end
  object mmoOutput: TMemo
    Left = 0
    Top = 570
    Width = 1289
    Height = 66
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
    OnKeyPress = BlockKeyPress
  end
  object pnlFiles: TPanel
    Left = 0
    Top = 0
    Width = 196
    Height = 567
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object pnlFilesButton: TPanel
      Left = 184
      Top = 0
      Width = 12
      Height = 567
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        12
        567)
      object btnFiles: TButton
        Left = 0
        Top = 0
        Width = 12
        Height = 567
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = '<'
        TabOrder = 0
        OnClick = btnFilesClick
      end
    end
    object pnlFilesInflate: TPanel
      Left = 0
      Top = 0
      Width = 184
      Height = 567
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object grpFiles: TGroupBox
        Left = 0
        Top = 0
        Width = 184
        Height = 433
        Align = alClient
        Caption = 'Files'
        TabOrder = 0
        object dirEdtIn: TJvDirectoryEdit
          Left = 2
          Top = 15
          Width = 180
          Height = 21
          Align = alTop
          TabOrder = 0
          OnChange = dirEdtInChange
        end
        object flIn: TFileListBox
          Left = 2
          Top = 36
          Width = 180
          Height = 395
          Align = alClient
          ItemHeight = 13
          Mask = '*.jpg;*.jpeg;*.png;*.webp;*.bmp;*.tif;*.tiff;'
          MultiSelect = True
          TabOrder = 1
          OnClick = flInClick
        end
      end
      object grpOutput: TGroupBox
        Left = 0
        Top = 433
        Width = 184
        Height = 134
        Align = alBottom
        Caption = 'Output'
        TabOrder = 1
        DesignSize = (
          184
          134)
        object rgOutputMode: TRadioGroup
          Left = 2
          Top = 15
          Width = 180
          Height = 46
          Align = alTop
          Caption = 'Output Mode'
          Columns = 2
          ItemIndex = 2
          Items.Strings = (
            'Directory'
            'Sub-Directory'
            'Replace/Edit')
          TabOrder = 0
          OnClick = rgOutputModeClick
        end
        object chkOverwrite: TCheckBox
          Left = 108
          Top = 1
          Width = 73
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Overwrite'
          TabOrder = 1
        end
        object pgcOutput: TPageControl
          Left = 2
          Top = 60
          Width = 179
          Height = 72
          ActivePage = tsOutputEdit
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          object tsOutputDirectory: TTabSheet
            Caption = 'Directory'
            object dirEdtOutput: TJvDirectoryEdit
              Left = 0
              Top = 0
              Width = 171
              Height = 21
              Align = alTop
              TabOrder = 0
              OnChange = dirEdtInChange
            end
          end
          object tsOutputSubDirectory: TTabSheet
            Caption = 'Sub Directory'
            ImageIndex = 1
            DesignSize = (
              171
              44)
            object edtOutputSubDirectory: TEdit
              Left = 2
              Top = 0
              Width = 168
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
              Text = 'ImageAI'
            end
          end
          object tsOutputEdit: TTabSheet
            Caption = 'Edit'
            ImageIndex = 2
            DesignSize = (
              171
              44)
            object lbledtOutputPrefix: TLabeledEdit
              Left = 32
              Top = 2
              Width = 141
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 28
              EditLabel.Height = 13
              EditLabel.Caption = 'Prefix'
              LabelPosition = lpLeft
              TabOrder = 0
              Text = 'ImageAI_'
            end
            object lbledtOutputSuffix: TLabeledEdit
              Left = 32
              Top = 24
              Width = 141
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 28
              EditLabel.Height = 13
              EditLabel.Caption = 'Suffix'
              LabelPosition = lpLeft
              TabOrder = 1
            end
          end
        end
      end
    end
  end
  object pnlControlsInflate: TPanel
    Left = 196
    Top = 0
    Width = 226
    Height = 567
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      226
      567)
    object btnControls: TButton
      Left = 214
      Top = 0
      Width = 12
      Height = 567
      Anchors = [akTop, akRight, akBottom]
      Caption = '<'
      TabOrder = 0
      OnClick = btnControlsClick
    end
    object pnlControls: TPanel
      Left = 0
      Top = 0
      Width = 214
      Height = 567
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        214
        567)
      object grpMode: TGroupBox
        Left = 0
        Top = 50
        Width = 214
        Height = 42
        Align = alTop
        Caption = 'Mode'
        TabOrder = 0
        DesignSize = (
          214
          42)
        object cbbMode: TComboBox
          Left = 5
          Top = 16
          Width = 205
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Waifu2x NCNN Vulkan'
          OnChange = cbbModeChange
          OnKeyPress = BlockKeyPress
          Items.Strings = (
            'Waifu2x NCNN Vulkan'
            'RealSR NCNN Vulkan (Scale x4)'
            'RealCugan NCNN Vulkan'
            'RealEsrgan NCNN Vulkan'
            'SRMD NCNN Vulkan'
            'Anime4k'
            'Waifu2x'
            'Waifu2x Caffe'
            'Cain NCNN Vulkan (Interpolation)'
            'Dain NCNN Vulkan (Interpolation)'
            'IfrNet NCNN Vulkan (Interpolation)'
            'Rife NCNN Vulkan (Interpolation)')
        end
      end
      object pnlControlsSub: TPanel
        Left = 0
        Top = 404
        Width = 214
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblTime: TLabel
          Left = 86
          Top = 8
          Width = 12
          Height = 13
          Caption = '---'
        end
        object btnProcess: TButton
          Left = 1
          Top = 1
          Width = 75
          Height = 25
          Caption = 'Process'
          TabOrder = 0
          OnClick = btnProcessClick
        end
      end
      object rgPreview: TRadioGroup
        Left = 0
        Top = 0
        Width = 214
        Height = 50
        Align = alTop
        Caption = 'Preview'
        Columns = 2
        ItemIndex = 2
        Items.Strings = (
          'Split (H)'
          'Split (V)'
          'Hold'
          'Click')
        TabOrder = 2
        OnClick = rgPreviewClick
      end
      object chkPreview: TCheckBox
        Left = 50
        Top = 0
        Width = 18
        Height = 17
        Anchors = [akTop]
        TabOrder = 3
        OnClick = chkPreviewClick
      end
      object chkPreviewFit: TCheckBox
        Left = 174
        Top = 0
        Width = 35
        Height = 17
        Anchors = [akTop]
        Caption = 'Fit'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = chkPreviewFitClick
      end
      object pnlModes: TPanel
        Left = 0
        Top = 92
        Width = 214
        Height = 312
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 5
        object pgcModes: TPageControl
          Left = 0
          Top = 0
          Width = 214
          Height = 312
          ActivePage = tsWNCNN
          Align = alClient
          TabOrder = 0
          object tsWNCNN: TTabSheet
            Caption = 'WNCNN'
            object grpWNCNN: TGroupBox
              Left = 0
              Top = 0
              Width = 206
              Height = 284
              Align = alClient
              Caption = 'Waifu2x NCNN Vulkan'
              TabOrder = 0
              DesignSize = (
                206
                284)
              object grpWNCNN_Model: TGroupBox
                Left = 2
                Top = 15
                Width = 202
                Height = 41
                Align = alTop
                Caption = 'Model'
                TabOrder = 0
                DesignSize = (
                  202
                  41)
                object cbbWNCNN_Model: TComboBox
                  Left = 4
                  Top = 16
                  Width = 199
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = 'Cunet'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'Cunet'
                    'Upconv 7 (Anime Style)'
                    'Upconf 7 (Photo)')
                end
              end
              object chkWNCNN_TTA: TCheckBox
                Left = 163
                Top = 0
                Width = 41
                Height = 17
                Hint = 'Test-Time Augmentation mode'
                Anchors = [akTop, akRight]
                Caption = 'TTA'
                TabOrder = 1
                OnClick = OnChange
              end
              object grpWNCNN_SyncGapMode: TGroupBox
                Left = 2
                Top = 100
                Width = 202
                Height = 41
                Align = alTop
                Caption = 'SyncGap Mode'
                TabOrder = 2
                Visible = False
                DesignSize = (
                  202
                  41)
                object cbbWNCNN_SyncGapMode: TComboBox
                  Left = 4
                  Top = 16
                  Width = 199
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 3
                  TabOrder = 0
                  Text = '3'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    '0'
                    '1'
                    '2'
                    '3')
                end
              end
              object pnlWNCNN: TPanel
                Left = 2
                Top = 56
                Width = 202
                Height = 44
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 3
                object grpWNCNN_Denoise: TGroupBox
                  Left = 1
                  Top = 1
                  Width = 66
                  Height = 41
                  Caption = 'Denoise'
                  TabOrder = 0
                  DesignSize = (
                    66
                    41)
                  object cbbWNCNN_Denoise: TComboBox
                    Left = 4
                    Top = 16
                    Width = 59
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    ItemHeight = 13
                    ItemIndex = 1
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyPress = BlockKeyPress
                    Items.Strings = (
                      '-1'
                      '0'
                      '1'
                      '2'
                      '3')
                  end
                end
                object grpWNCNN_Scale: TGroupBox
                  Left = 70
                  Top = 1
                  Width = 66
                  Height = 41
                  Caption = 'Scale'
                  TabOrder = 1
                  DesignSize = (
                    66
                    41)
                  object cbbWNCNN_Scale: TComboBox
                    Left = 4
                    Top = 16
                    Width = 59
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    ItemHeight = 13
                    ItemIndex = 1
                    TabOrder = 0
                    Text = '2'
                    OnChange = OnChange
                    OnKeyPress = BlockKeyPress
                    Items.Strings = (
                      '1'
                      '2'
                      '4'
                      '8'
                      '16'
                      '32')
                  end
                end
                object grpWNCNN_Format: TGroupBox
                  Left = 139
                  Top = 1
                  Width = 66
                  Height = 41
                  Caption = 'Format'
                  TabOrder = 2
                  DesignSize = (
                    66
                    41)
                  object cbbWNCNN_Format: TComboBox
                    Left = 5
                    Top = 16
                    Width = 59
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    ItemHeight = 13
                    ItemIndex = 0
                    TabOrder = 0
                    Text = 'Default'
                    OnKeyPress = BlockKeyPress
                    Items.Strings = (
                      'Default'
                      'JPG'
                      'PNG'
                      'WebP')
                  end
                end
              end
            end
          end
          object tsAnime4k: TTabSheet
            Caption = 'Anime4k'
            ImageIndex = 1
            object grpAnime4k: TGroupBox
              Left = 0
              Top = 0
              Width = 206
              Height = 284
              Align = alClient
              Caption = 'Anime4k'
              TabOrder = 0
              object grpA4k_CNNMode: TGroupBox
                Left = 5
                Top = 98
                Width = 76
                Height = 62
                Caption = 'CNNMode'
                Enabled = False
                TabOrder = 6
                object grpA4k_HDN: TGroupBox
                  Left = 2
                  Top = 14
                  Width = 71
                  Height = 45
                  Caption = 'HDN'
                  Enabled = False
                  TabOrder = 0
                  DesignSize = (
                    71
                    45)
                  object edtA4k_HDNLevel: TEdit
                    Left = 4
                    Top = 20
                    Width = 63
                    Height = 21
                    Hint = 'Set HDN level'
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '1'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                    OnKeyUp = edtA4k_HDNLevelKeyUp
                  end
                end
                object chkA4k_HDN: TCheckBox
                  Left = 35
                  Top = 14
                  Width = 16
                  Height = 17
                  Hint = 'Enable HDN mode for ACNet'
                  Enabled = False
                  TabOrder = 1
                  OnClick = chkA4k_HDNClick
                end
              end
              object chkA4k_NCNN: TCheckBox
                Left = 5
                Top = 52
                Width = 51
                Height = 17
                Hint = 'Open ncnn and ACNet'
                Caption = 'NCNN'
                Enabled = False
                TabOrder = 2
                OnClick = OnChange
              end
              object chkA4k_GPUMode: TCheckBox
                Left = 5
                Top = 16
                Width = 72
                Height = 17
                Hint = 'Enable GPU acceleration'
                Caption = 'GPU Mode'
                Checked = True
                State = cbChecked
                TabOrder = 0
                OnClick = OnChange
              end
              object chkA4k_FastMode: TCheckBox
                Left = 5
                Top = 34
                Width = 72
                Height = 17
                Hint = 'Faster but maybe low quality'
                Caption = 'Fast Mode'
                TabOrder = 1
                OnClick = OnChange
              end
              object grpA4k_Scale: TGroupBox
                Left = 85
                Top = 7
                Width = 60
                Height = 43
                Caption = 'Scale'
                TabOrder = 3
                DesignSize = (
                  60
                  43)
                object edtA4k_Scale: TEdit
                  Left = 4
                  Top = 18
                  Width = 52
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '2.0'
                  OnChange = OnChange
                  OnKeyDown = FloatUnsignedKeyDown
                  OnKeyPress = FloatUnsignedKeyPress
                end
              end
              object grpA4k_Passes: TGroupBox
                Left = 146
                Top = 7
                Width = 60
                Height = 43
                Caption = 'Passes'
                TabOrder = 4
                DesignSize = (
                  60
                  43)
                object edtA4k_Passes: TEdit
                  Left = 4
                  Top = 18
                  Width = 52
                  Height = 21
                  Hint = 'Passes for processing'
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '2'
                  OnChange = OnChange
                  OnKeyDown = UnsignedKeyDown
                  OnKeyPress = UnsignedKeyPress
                  OnKeyUp = edtA4k_PassesKeyUp
                end
              end
              object grpA4k_PushColorCount: TGroupBox
                Left = 85
                Top = 52
                Width = 121
                Height = 43
                Caption = 'Push Color Count'
                TabOrder = 5
                DesignSize = (
                  121
                  43)
                object edtA4k_PushColorCount: TEdit
                  Left = 4
                  Top = 18
                  Width = 113
                  Height = 21
                  Hint = 'Limit the number of color pushes'
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '3'
                  OnChange = OnChange
                  OnKeyDown = UnsignedKeyDown
                  OnKeyPress = UnsignedKeyPress
                  OnKeyUp = edtA4k_PushColorCountKeyUp
                end
              end
              object grpA4k_Strength: TGroupBox
                Left = 88
                Top = 98
                Width = 118
                Height = 63
                Caption = 'Strength'
                TabOrder = 7
                object grpA4k_StrengthColor: TGroupBox
                  Left = 2
                  Top = 17
                  Width = 56
                  Height = 43
                  Caption = 'Color'
                  TabOrder = 0
                  DesignSize = (
                    56
                    43)
                  object edtA4k_StrengthColor: TEdit
                    Left = 4
                    Top = 18
                    Width = 49
                    Height = 21
                    Hint = 'Strength for pushing color, Range 0 to 1, Higher for thinner'
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    Text = '0.3'
                    OnChange = OnChange
                    OnKeyDown = FloatUnsignedKeyDown
                    OnKeyPress = FloatUnsignedKeyPress
                    OnKeyUp = edtA4k_StrengthKeyUp
                  end
                end
                object grpA4k_StrengthGradient: TGroupBox
                  Left = 59
                  Top = 17
                  Width = 56
                  Height = 43
                  Caption = 'Gradient'
                  TabOrder = 1
                  DesignSize = (
                    56
                    43)
                  object edtA4k_StrengthGradient: TEdit
                    Left = 4
                    Top = 18
                    Width = 49
                    Height = 21
                    Hint = 'Strength for pushing gradient, Range 0 to 1, Higher for sharper'
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    Text = '1'
                    OnChange = OnChange
                    OnKeyDown = FloatUnsignedKeyDown
                    OnKeyPress = FloatUnsignedKeyPress
                    OnKeyUp = edtA4k_StrengthKeyUp
                  end
                end
              end
              object pgcA4k_Filters: TPageControl
                Left = 2
                Top = 161
                Width = 202
                Height = 121
                ActivePage = tsA4k_PreFilters
                Align = alBottom
                TabOrder = 8
                object tsA4k_PreFilters: TTabSheet
                  Caption = 'PreFilters'
                  object grpA4k_PreFilters: TGroupBox
                    Left = 0
                    Top = 0
                    Width = 194
                    Height = 93
                    Align = alClient
                    Caption = 'PreFilters'
                    Enabled = False
                    TabOrder = 0
                    object chkA4k_PreFiltersMedianBlur: TCheckBox
                      Left = 4
                      Top = 17
                      Width = 72
                      Height = 17
                      Caption = 'MedianBlur'
                      Enabled = False
                      TabOrder = 0
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersMeanBlur: TCheckBox
                      Left = 4
                      Top = 35
                      Width = 65
                      Height = 17
                      Caption = 'MeanBlur'
                      Enabled = False
                      TabOrder = 1
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersCasSharpening: TCheckBox
                      Left = 78
                      Top = 54
                      Width = 97
                      Height = 17
                      Caption = 'CAS Sharpening'
                      Checked = True
                      Enabled = False
                      State = cbChecked
                      TabOrder = 2
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersGaussianBlurWeak: TCheckBox
                      Left = 78
                      Top = 17
                      Width = 117
                      Height = 17
                      Caption = 'GaussianBlur (Weak)'
                      Enabled = False
                      TabOrder = 3
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersGaussianBlur: TCheckBox
                      Left = 78
                      Top = 35
                      Width = 89
                      Height = 17
                      Caption = 'GaussianBlur'
                      Enabled = False
                      TabOrder = 4
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersBilateralFilter: TCheckBox
                      Left = 4
                      Top = 54
                      Width = 60
                      Height = 17
                      Caption = 'Bilateral'
                      Enabled = False
                      TabOrder = 5
                      OnClick = OnChange
                    end
                    object chkA4k_PreFiltersBilateralFilterFaster: TCheckBox
                      Left = 4
                      Top = 73
                      Width = 129
                      Height = 17
                      Caption = 'Bilateral Filter (Faster)'
                      Enabled = False
                      TabOrder = 6
                      OnClick = OnChange
                    end
                  end
                  object chkA4k_PreFilters: TCheckBox
                    Left = 61
                    Top = 0
                    Width = 16
                    Height = 17
                    TabOrder = 1
                    OnClick = chkA4k_PreFiltersClick
                  end
                end
                object tsA4k_PostFilters: TTabSheet
                  Caption = 'PostFilters'
                  ImageIndex = 1
                  object grpA4k_PostFilters: TGroupBox
                    Left = 0
                    Top = 0
                    Width = 194
                    Height = 93
                    Align = alClient
                    Caption = 'PostFilters'
                    Enabled = False
                    TabOrder = 0
                    object chkA4k_PostFiltersMedianBlur: TCheckBox
                      Left = 4
                      Top = 17
                      Width = 72
                      Height = 17
                      Caption = 'MedianBlur'
                      Enabled = False
                      TabOrder = 0
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersMeanBlur: TCheckBox
                      Left = 4
                      Top = 35
                      Width = 65
                      Height = 17
                      Caption = 'MeanBlur'
                      Enabled = False
                      TabOrder = 1
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersCasSharpening: TCheckBox
                      Left = 78
                      Top = 54
                      Width = 98
                      Height = 17
                      Caption = 'CAS Sharpening'
                      Checked = True
                      Enabled = False
                      State = cbChecked
                      TabOrder = 2
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersGaussianBlurWeak: TCheckBox
                      Left = 78
                      Top = 17
                      Width = 117
                      Height = 17
                      Caption = 'GaussianBlur (Weak)'
                      Enabled = False
                      TabOrder = 3
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersGaussianBlur: TCheckBox
                      Left = 78
                      Top = 35
                      Width = 89
                      Height = 17
                      Caption = 'GaussianBlur'
                      Enabled = False
                      TabOrder = 4
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersBilateralFilter: TCheckBox
                      Left = 4
                      Top = 54
                      Width = 60
                      Height = 17
                      Caption = 'Bilateral'
                      Checked = True
                      Enabled = False
                      State = cbChecked
                      TabOrder = 5
                      OnClick = OnChange
                    end
                    object chkA4k_PostFiltersBilateralFilterFaster: TCheckBox
                      Left = 4
                      Top = 73
                      Width = 129
                      Height = 17
                      Caption = 'Bilateral Filter (Faster)'
                      Enabled = False
                      TabOrder = 6
                      OnClick = OnChange
                    end
                  end
                  object chkA4k_PostFilters: TCheckBox
                    Left = 61
                    Top = 0
                    Width = 16
                    Height = 17
                    TabOrder = 1
                    OnClick = chkA4k_PostFiltersClick
                  end
                end
              end
              object chkA4k_CNNMode: TCheckBox
                Left = 63
                Top = 97
                Width = 15
                Height = 19
                Hint = 'Enable ACNet'
                TabOrder = 9
                OnClick = chkA4k_CNNModeClick
              end
            end
          end
          object tsWaifu2x: TTabSheet
            Caption = 'Waifu2x'
            ImageIndex = 2
            object grpWaifu2x: TGroupBox
              Left = 0
              Top = 0
              Width = 206
              Height = 284
              Align = alClient
              Caption = 'Waifu2x'
              TabOrder = 0
              object grpWaifu2x_Scale: TGroupBox
                Left = 3
                Top = 18
                Width = 66
                Height = 41
                Caption = 'Scale'
                Enabled = False
                TabOrder = 0
                DesignSize = (
                  66
                  41)
                object edtWaifu2x_Scale: TEdit
                  Left = 4
                  Top = 16
                  Width = 59
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  Enabled = False
                  TabOrder = 0
                  Text = '2,0'
                  OnChange = OnChange
                  OnKeyDown = FloatUnsignedKeyDown
                  OnKeyPress = FloatUnsignedKeyPress
                end
              end
              object chkWaifu2x_Scale: TCheckBox
                Left = 51
                Top = 16
                Width = 15
                Height = 17
                TabOrder = 1
                OnClick = chkWaifu2x_ScaleClick
              end
              object grpWaifu2x_Denoise: TGroupBox
                Left = 70
                Top = 17
                Width = 66
                Height = 41
                Caption = 'Denoise'
                Enabled = False
                TabOrder = 2
                DesignSize = (
                  66
                  41)
                object cbbWaifu2x_Denoise: TComboBox
                  Left = 4
                  Top = 16
                  Width = 59
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  Enabled = False
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = '0'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    '0'
                    '1'
                    '2'
                    '3')
                end
              end
              object chkWaifu2x_Denoise: TCheckBox
                Left = 119
                Top = 16
                Width = 15
                Height = 17
                TabOrder = 3
                OnClick = chkWaifu2x_DenoiseClick
              end
              object chkWaifu2x_TTA: TCheckBox
                Left = 6
                Top = 105
                Width = 40
                Height = 17
                Hint = 'Test-Time Augmentation mode'
                Caption = 'TTA'
                TabOrder = 4
                OnClick = OnChange
              end
              object chkWaifu2x_GPU: TCheckBox
                Left = 48
                Top = 105
                Width = 43
                Height = 17
                Caption = 'GPU'
                Checked = True
                State = cbChecked
                TabOrder = 5
                OnClick = OnChange
              end
              object chkWaifu2x_ForceOpenCL: TCheckBox
                Left = 98
                Top = 105
                Width = 89
                Height = 17
                Hint = 'Force to use OpenCL on Intel Platform'
                Caption = 'Force OpenCL'
                TabOrder = 6
                OnClick = OnChange
              end
              object grpWaifu2x_PNGCompression: TGroupBox
                Left = 3
                Top = 61
                Width = 100
                Height = 41
                Caption = 'PNG Compression'
                TabOrder = 7
                DesignSize = (
                  100
                  41)
                object edtWaifu2x_PNGCompression: TEdit
                  Left = 6
                  Top = 16
                  Width = 92
                  Height = 21
                  Hint = 
                    'PNG compression level (0-9), 9 = Max compression (slowest & smal' +
                    'lest)'
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '0'
                  OnKeyDown = UnsignedKeyDown
                  OnKeyPress = UnsignedKeyPress
                  OnKeyUp = edtWaifu2x_PNGCompressionKeyUp
                end
              end
              object grpWaifu2x_JPEGCompression: TGroupBox
                Left = 103
                Top = 61
                Width = 100
                Height = 41
                Caption = 'JPEG Compression'
                TabOrder = 8
                DesignSize = (
                  100
                  41)
                object edtWaifu2x_JPEGCompression: TEdit
                  Left = 4
                  Top = 16
                  Width = 92
                  Height = 21
                  Hint = 
                    'JPEG & WebP Compression quality (0-101, 0 being smallest size an' +
                    'd lowest quality), use 101 for lossless WebP'
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '101'
                  OnKeyDown = UnsignedKeyDown
                  OnKeyPress = UnsignedKeyPress
                  OnKeyUp = edtWaifu2x_JPEGCompressionKeyUp
                end
              end
              object grpWaifu2x_Format: TGroupBox
                Left = 138
                Top = 17
                Width = 66
                Height = 41
                Caption = 'Format'
                TabOrder = 9
                DesignSize = (
                  66
                  41)
                object cbbWaifu2x_Format: TComboBox
                  Left = 5
                  Top = 16
                  Width = 59
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = 'Default'
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'Default'
                    'JPG'
                    'PNG'
                    'WebP')
                end
              end
            end
          end
          object tsWaifu2x_Caffe: TTabSheet
            Caption = 'Waifu2x Caffe'
            ImageIndex = 3
            object grpWaifu2x_Caffe: TGroupBox
              Left = 0
              Top = 0
              Width = 206
              Height = 284
              Align = alClient
              Caption = 'Waifu2x Caffe'
              TabOrder = 0
              object grpWaifu2x_Caffe_Model: TGroupBox
                Left = 2
                Top = 47
                Width = 202
                Height = 41
                Align = alTop
                Caption = 'Model'
                TabOrder = 0
                DesignSize = (
                  202
                  41)
                object cbbWaifu2x_Caffe_Model: TComboBox
                  Left = 4
                  Top = 16
                  Width = 195
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = 'CUnet'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'CUnet'
                    'Anime Style Art RGB'
                    'Anime Style Art'
                    'Photo'
                    'Upconv 7 Anime Style Art RGB'
                    'Upconv 7 Photo'
                    'UpResNet10'
                    'UkBench')
                end
              end
              object rgWaifu2x_Caffe_Mode: TRadioGroup
                Left = 2
                Top = 15
                Width = 202
                Height = 32
                Align = alTop
                Caption = 'Mode'
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  'CPU'
                  'GPU'
                  'Cudnn')
                TabOrder = 1
                OnClick = OnChange
              end
              object grpWaifu2x_Caffe_Denoise: TGroupBox
                Left = 4
                Top = 214
                Width = 67
                Height = 41
                Caption = 'Denoise'
                TabOrder = 2
                DesignSize = (
                  67
                  41)
                object cbbWaifu2x_Caffe_Denoise: TComboBox
                  Left = 4
                  Top = 16
                  Width = 61
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = 'Off'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'Off'
                    'Auto'
                    '0'
                    '1'
                    '2'
                    '3')
                end
              end
              object grpWaifu2x_Caffe_ImageQuality: TGroupBox
                Left = 74
                Top = 214
                Width = 82
                Height = 41
                Caption = 'Image Quality'
                TabOrder = 3
                DesignSize = (
                  82
                  41)
                object edtWaifu2x_Caffe_ImageQuality: TEdit
                  Left = 4
                  Top = 16
                  Width = 74
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  Text = '-1'
                end
              end
              object chkWaifu2x_Caffe_TTA: TCheckBox
                Left = 158
                Top = 233
                Width = 40
                Height = 17
                Hint = 'Test-Time Augmentation mode'
                Caption = 'TTA'
                TabOrder = 4
                OnClick = OnChange
              end
              object grpWaifu2x_Caffe_Scale: TGroupBox
                Left = 2
                Top = 88
                Width = 202
                Height = 62
                Align = alTop
                Caption = 'Scale'
                TabOrder = 5
                object grpWaifu2x_Caffe_ScaleFactor: TGroupBox
                  Left = 3
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Factor'
                  Enabled = False
                  TabOrder = 0
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_ScaleFactor: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '2.0'
                    OnChange = OnChange
                    OnKeyDown = FloatUnsignedKeyDown
                    OnKeyPress = FloatUnsignedKeyPress
                  end
                end
                object grpWaifu2x_Caffe_ScaleWidth: TGroupBox
                  Left = 69
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Width'
                  Enabled = False
                  TabOrder = 1
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_ScaleWidth: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Hint = 'Target Width - Set Width and Height 0 to use Factor'
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
                object grpWaifu2x_Caffe_ScaleHeight: TGroupBox
                  Left = 135
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Height'
                  Enabled = False
                  TabOrder = 2
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_ScaleHeight: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Hint = 'Target Height - Set Width and Height 0 to use Factor'
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
              end
              object chkWaifu2x_Caffe_Scale: TCheckBox
                Left = 40
                Top = 87
                Width = 15
                Height = 17
                TabOrder = 6
                OnClick = chkWaifu2x_Caffe_ScaleClick
              end
              object grpWaifu2x_Caffe_Crop: TGroupBox
                Left = 2
                Top = 150
                Width = 202
                Height = 62
                Align = alTop
                Caption = 'Crop'
                TabOrder = 7
                object grpWaifu2x_Caffe_CropWidth: TGroupBox
                  Left = 3
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Width'
                  TabOrder = 0
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_CropWidth: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Hint = 'Crop to Width - 0 = Disabled'
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
                object grpWaifu2x_Caffe_CropHeight: TGroupBox
                  Left = 67
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Height'
                  TabOrder = 1
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_CropHeight: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Hint = 'Crop to Height - 0 = Disabled'
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
                object grpWaifu2x_Caffe_CropDivisor: TGroupBox
                  Left = 133
                  Top = 15
                  Width = 65
                  Height = 43
                  Caption = 'Divisor'
                  TabOrder = 2
                  DesignSize = (
                    65
                    43)
                  object edtWaifu2x_Caffe_CropDivisor: TEdit
                    Left = 4
                    Top = 18
                    Width = 57
                    Height = 21
                    Hint = 'Specify the division size. The default value is `128`'
                    Anchors = [akLeft, akTop, akRight]
                    TabOrder = 0
                    Text = '128'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
              end
            end
          end
          object tsDain: TTabSheet
            Caption = 'Dain'
            ImageIndex = 5
            object grpDain: TGroupBox
              Left = 0
              Top = 0
              Width = 206
              Height = 284
              Align = alClient
              Caption = 'Dain'
              TabOrder = 0
              object pnlDain: TPanel
                Left = 2
                Top = 15
                Width = 202
                Height = 41
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object grpDain_FrameCount: TGroupBox
                  Left = 4
                  Top = 0
                  Width = 75
                  Height = 41
                  Caption = 'Frame Count'
                  TabOrder = 0
                  DesignSize = (
                    75
                    41)
                  object edtDain_FrameCount: TEdit
                    Left = 4
                    Top = 18
                    Width = 66
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '0'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
                object grpDain_TimeStep: TGroupBox
                  Left = 80
                  Top = 0
                  Width = 61
                  Height = 41
                  Caption = 'Time Step'
                  TabOrder = 1
                  DesignSize = (
                    61
                    41)
                  object edtDain_TimeStep: TEdit
                    Left = 4
                    Top = 18
                    Width = 52
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '0,5'
                    OnChange = OnChange
                    OnKeyDown = FloatUnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
                object grpDain_TileSize: TGroupBox
                  Left = 141
                  Top = 0
                  Width = 61
                  Height = 41
                  Caption = 'Tile Size'
                  TabOrder = 2
                  DesignSize = (
                    61
                    41)
                  object edtDain_TileSize: TEdit
                    Left = 4
                    Top = 18
                    Width = 52
                    Height = 21
                    Anchors = [akLeft, akTop, akRight]
                    Enabled = False
                    TabOrder = 0
                    Text = '256'
                    OnChange = OnChange
                    OnKeyDown = UnsignedKeyDown
                    OnKeyPress = UnsignedKeyPress
                  end
                end
              end
              object grpIfrNet_Model: TGroupBox
                Left = 2
                Top = 56
                Width = 202
                Height = 41
                Align = alTop
                Caption = 'Model'
                TabOrder = 1
                DesignSize = (
                  202
                  41)
                object cbbIfrNet_Model: TComboBox
                  Left = 4
                  Top = 16
                  Width = 195
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 0
                  TabOrder = 0
                  Text = 'Vimeo90K'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'Vimeo90K'
                    'Vimeo90K S'
                    'Vimeo90K L'
                    'GoPro'
                    'GoPro S'
                    'GoPro L')
                end
              end
              object grpRife_Model: TGroupBox
                Left = 2
                Top = 97
                Width = 202
                Height = 41
                Align = alTop
                Caption = 'Model'
                TabOrder = 2
                DesignSize = (
                  202
                  41)
                object cbbRife_Model: TComboBox
                  Left = 4
                  Top = 16
                  Width = 195
                  Height = 21
                  Anchors = [akLeft, akTop, akRight]
                  ItemHeight = 13
                  ItemIndex = 5
                  TabOrder = 0
                  Text = 'Rife v2.3'
                  OnChange = OnChange
                  OnKeyPress = BlockKeyPress
                  Items.Strings = (
                    'Rife'
                    'Rife Anime'
                    'Rife HD'
                    'Rife UHD'
                    'Rife v2'
                    'Rife v2.3'
                    'Rife v2.4'
                    'Rife v3.0'
                    'Rife v3.1'
                    'Rife v4')
                end
              end
              object chkDain_UltraHD: TCheckBox
                Left = 144
                Top = 38
                Width = 58
                Height = 17
                Caption = 'UltraHD'
                TabOrder = 3
                OnClick = OnChange
              end
              object chkDain_TTA: TCheckBox
                Left = 144
                Top = 20
                Width = 44
                Height = 17
                Caption = 'TTA'
                TabOrder = 4
                OnClick = OnChange
              end
            end
          end
        end
      end
    end
  end
  object pnlProgress: TPanel
    Left = 4
    Top = 283
    Width = 1285
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Visible = False
    DesignSize = (
      1285
      41)
    object lblProgress: TLabel
      Left = 1
      Top = 27
      Width = 1283
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = '0 / 1'
    end
    object pbProgress: TProgressBar
      Left = 1
      Top = 1
      Width = 1283
      Height = 26
      Align = alClient
      Max = 1
      Smooth = True
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 602
      Top = 3
      Width = 75
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
