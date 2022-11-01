unit Main;

interface

uses
  Windows, Classes, Controls, Graphics, Forms,
  StdCtrls, FileCtrl, Mask, JvExMask, JvToolEdit, ExtCtrls, ComCtrls,
  SyncObjs,
  uImageAI,
  uTLH.ComponentTools;

type
  TDataRecord = packed record
    FileNameIn1,
    FileNameIn2,
    FileNameOut : String;
    Preview     : Boolean;
    Overwrite   : Boolean;

    Data        : TDataRecordUnion;
  end;

  TCompleteEvent = procedure(Sender: TObject; FileName : String; Result : Integer) of object;
  TProcessThread = class(TThread)
  private
    fCrit        : TCriticalSection;
    fOut         : TStringList;
    fItems       : Array of TDataRecord;
    fData        : TDataRecord;
    fTime        : Cardinal;
    fResult      : Integer;
    fOnPreview   : TCompleteEvent;
    fOnComplete  : TCompleteEvent;
    fCancel      : Boolean;
    procedure   Process( Data : TDataRecord );
    procedure   ExecutePELine( const Line: string; var Aborted: Boolean; IsStatus : boolean );
    function    GetTime : Cardinal;
    function    GetOutput : String;
    function    GetResult : Integer;
    function    GetCancel : Boolean;
    procedure   SetCancel( Value : Boolean );
  protected
    procedure   Execute; override;
  public
    Constructor Create( CreateSuspended : boolean = False ); reintroduce;
    destructor  Destroy; override;
    procedure   AddItem( Data : TDataRecord );
    property    OnPreview  : TCompleteEvent read fOnPreview  write fOnPreview;
    property    OnComplete : TCompleteEvent read fOnComplete write fOnComplete;
    property    Time       : Cardinal       read GetTime;
    property    Output     : String         read GetOutput;
    property    Result     : Integer        read GetResult;
    property    Cancel     : Boolean        read GetCancel   write SetCancel;
  end;

  TImage = class(ExtCtrls.TImage);

  TFrmImageAI = class(TForm)
    pnlPreview: TPanel;
    ScrlBoxIn: TScrollBox;
    imgIn: TImage;
    splPreview: TSplitter;
    ScrlBoxPreview: TScrollBox;
    pnlProgress: TPanel;
    pbProgress: TProgressBar;
    lblProgress: TLabel;
    btnCancel: TButton;
    imgPreview: TImage;
    mmoOutput: TMemo;
    splMemo: TSplitter;
    pnlFiles: TPanel;
    pnlControlsInflate: TPanel;
    btnControls: TButton;
    pnlControls: TPanel;
    grpMode: TGroupBox;
    cbbMode: TComboBox;
    pnlControlsSub: TPanel;
    lblTime: TLabel;
    btnProcess: TButton;
    rgPreview: TRadioGroup;
    chkPreview: TCheckBox;
    chkPreviewFit: TCheckBox;
    pnlModes: TPanel;
    pgcModes: TPageControl;
    tsWNCNN: TTabSheet;
    grpWNCNN: TGroupBox;
    grpWNCNN_Model: TGroupBox;
    cbbWNCNN_Model: TComboBox;
    chkWNCNN_TTA: TCheckBox;
    grpWNCNN_SyncGapMode: TGroupBox;
    cbbWNCNN_SyncGapMode: TComboBox;
    pnlWNCNN: TPanel;
    grpWNCNN_Denoise: TGroupBox;
    cbbWNCNN_Denoise: TComboBox;
    grpWNCNN_Scale: TGroupBox;
    cbbWNCNN_Scale: TComboBox;
    grpWNCNN_Format: TGroupBox;
    cbbWNCNN_Format: TComboBox;
    tsAnime4k: TTabSheet;
    grpAnime4k: TGroupBox;
    grpA4k_CNNMode: TGroupBox;
    grpA4k_HDN: TGroupBox;
    edtA4k_HDNLevel: TEdit;
    chkA4k_HDN: TCheckBox;
    chkA4k_NCNN: TCheckBox;
    chkA4k_GPUMode: TCheckBox;
    chkA4k_FastMode: TCheckBox;
    grpA4k_Scale: TGroupBox;
    edtA4k_Scale: TEdit;
    grpA4k_Passes: TGroupBox;
    edtA4k_Passes: TEdit;
    grpA4k_PushColorCount: TGroupBox;
    edtA4k_PushColorCount: TEdit;
    grpA4k_Strength: TGroupBox;
    grpA4k_StrengthColor: TGroupBox;
    edtA4k_StrengthColor: TEdit;
    grpA4k_StrengthGradient: TGroupBox;
    edtA4k_StrengthGradient: TEdit;
    pgcA4k_Filters: TPageControl;
    tsA4k_PreFilters: TTabSheet;
    grpA4k_PreFilters: TGroupBox;
    chkA4k_PreFiltersMedianBlur: TCheckBox;
    chkA4k_PreFiltersMeanBlur: TCheckBox;
    chkA4k_PreFiltersCasSharpening: TCheckBox;
    chkA4k_PreFiltersGaussianBlurWeak: TCheckBox;
    chkA4k_PreFiltersGaussianBlur: TCheckBox;
    chkA4k_PreFiltersBilateralFilter: TCheckBox;
    chkA4k_PreFiltersBilateralFilterFaster: TCheckBox;
    chkA4k_PreFilters: TCheckBox;
    tsA4k_PostFilters: TTabSheet;
    grpA4k_PostFilters: TGroupBox;
    chkA4k_PostFiltersMedianBlur: TCheckBox;
    chkA4k_PostFiltersMeanBlur: TCheckBox;
    chkA4k_PostFiltersCasSharpening: TCheckBox;
    chkA4k_PostFiltersGaussianBlurWeak: TCheckBox;
    chkA4k_PostFiltersGaussianBlur: TCheckBox;
    chkA4k_PostFiltersBilateralFilter: TCheckBox;
    chkA4k_PostFiltersBilateralFilterFaster: TCheckBox;
    chkA4k_PostFilters: TCheckBox;
    chkA4k_CNNMode: TCheckBox;
    tsWaifu2x: TTabSheet;
    grpWaifu2x: TGroupBox;
    grpWaifu2x_Scale: TGroupBox;
    edtWaifu2x_Scale: TEdit;
    chkWaifu2x_Scale: TCheckBox;
    grpWaifu2x_Denoise: TGroupBox;
    cbbWaifu2x_Denoise: TComboBox;
    chkWaifu2x_Denoise: TCheckBox;
    chkWaifu2x_TTA: TCheckBox;
    chkWaifu2x_GPU: TCheckBox;
    chkWaifu2x_ForceOpenCL: TCheckBox;
    grpWaifu2x_PNGCompression: TGroupBox;
    edtWaifu2x_PNGCompression: TEdit;
    grpWaifu2x_JPEGCompression: TGroupBox;
    edtWaifu2x_JPEGCompression: TEdit;
    grpWaifu2x_Format: TGroupBox;
    cbbWaifu2x_Format: TComboBox;
    tsWaifu2x_Caffe: TTabSheet;
    grpWaifu2x_Caffe: TGroupBox;
    grpWaifu2x_Caffe_Model: TGroupBox;
    cbbWaifu2x_Caffe_Model: TComboBox;
    rgWaifu2x_Caffe_Mode: TRadioGroup;
    grpWaifu2x_Caffe_Denoise: TGroupBox;
    cbbWaifu2x_Caffe_Denoise: TComboBox;
    grpWaifu2x_Caffe_ImageQuality: TGroupBox;
    edtWaifu2x_Caffe_ImageQuality: TEdit;
    chkWaifu2x_Caffe_TTA: TCheckBox;
    grpWaifu2x_Caffe_Scale: TGroupBox;
    grpWaifu2x_Caffe_ScaleFactor: TGroupBox;
    edtWaifu2x_Caffe_ScaleFactor: TEdit;
    grpWaifu2x_Caffe_ScaleWidth: TGroupBox;
    edtWaifu2x_Caffe_ScaleWidth: TEdit;
    grpWaifu2x_Caffe_ScaleHeight: TGroupBox;
    edtWaifu2x_Caffe_ScaleHeight: TEdit;
    chkWaifu2x_Caffe_Scale: TCheckBox;
    grpWaifu2x_Caffe_Crop: TGroupBox;
    grpWaifu2x_Caffe_CropWidth: TGroupBox;
    edtWaifu2x_Caffe_CropWidth: TEdit;
    grpWaifu2x_Caffe_CropHeight: TGroupBox;
    edtWaifu2x_Caffe_CropHeight: TEdit;
    grpWaifu2x_Caffe_CropDivisor: TGroupBox;
    edtWaifu2x_Caffe_CropDivisor: TEdit;
    tsDain: TTabSheet;
    grpDain: TGroupBox;
    pnlDain: TPanel;
    grpDain_FrameCount: TGroupBox;
    edtDain_FrameCount: TEdit;
    grpDain_TimeStep: TGroupBox;
    edtDain_TimeStep: TEdit;
    grpDain_TileSize: TGroupBox;
    edtDain_TileSize: TEdit;
    grpIfrNet_Model: TGroupBox;
    cbbIfrNet_Model: TComboBox;
    grpRife_Model: TGroupBox;
    cbbRife_Model: TComboBox;
    chkDain_UltraHD: TCheckBox;
    chkDain_TTA: TCheckBox;
    pnlFilesButton: TPanel;
    btnFiles: TButton;
    pnlFilesInflate: TPanel;
    grpFiles: TGroupBox;
    dirEdtIn: TJvDirectoryEdit;
    flIn: TFileListBox;
    grpOutput: TGroupBox;
    rgOutputMode: TRadioGroup;
    chkOverwrite: TCheckBox;
    pgcOutput: TPageControl;
    tsOutputDirectory: TTabSheet;
    dirEdtOutput: TJvDirectoryEdit;
    tsOutputSubDirectory: TTabSheet;
    edtOutputSubDirectory: TEdit;
    tsOutputEdit: TTabSheet;
    lbledtOutputPrefix: TLabeledEdit;
    lbledtOutputSuffix: TLabeledEdit;
    procedure dirEdtInChange(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure BlockKeyPress(Sender: TObject; var Key: Char);
    procedure flInClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure chkPreviewClick(Sender: TObject);
    procedure cbbModeChange(Sender: TObject);
    procedure chkPreviewFitClick(Sender: TObject);
    procedure rgPreviewClick(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure imgMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure splPreviewMoved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure chkA4k_PreFiltersClick(Sender: TObject);
    procedure chkA4k_PostFiltersClick(Sender: TObject);
    procedure FloatUnsignedKeyPress(Sender: TObject; var Key: Char);
    procedure UnsignedKeyPress(Sender: TObject; var Key: Char);
    procedure FloatUnsignedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UnsignedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtA4k_StrengthKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtA4k_HDNLevelKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkA4k_HDNClick(Sender: TObject);
    procedure chkA4k_CNNModeClick(Sender: TObject);
    procedure edtA4k_PassesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtA4k_PushColorCountKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure edtWaifu2x_PNGCompressionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtWaifu2x_JPEGCompressionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkWaifu2x_ScaleClick(Sender: TObject);
    procedure chkWaifu2x_DenoiseClick(Sender: TObject);
    procedure chkWaifu2x_Caffe_ScaleClick(Sender: TObject);
    procedure btnFilesClick(Sender: TObject);
    procedure btnControlsClick(Sender: TObject);
    procedure rgOutputModeClick(Sender: TObject);
  private
    { Private-Deklarationen }
    fInWidth,
    fInHeight,
    fPreviewWidth,
    fPreviewHeight : Integer;
    fPanning : Boolean;
    fPanningX,
    fPanningY : Integer;
    fPanningLX,
    fPanningLY : Integer;
    fThread : TProcessThread;
    fTimer  : TTimer;
    fPreviewFile : String;
    fCrit : TCriticalSection;
    procedure UpdateImageDimension( Fit : Boolean );
    procedure LoadImage( FileName : string; Image : TImage );
    procedure OnTimer(Sender: TObject);
    procedure OnPreview(Sender: TObject; FileName : String; Result : Integer);
    procedure OnComplete(Sender: TObject; FileName : String; Result : Integer);
    function  GetSettings( FileNameIn1, FileNameIn2, FileNameOut : String; var Data : TDataRecord; Preview : Boolean = False ) : Boolean;
  public
    { Public-Deklarationen }
  end;

var
  FrmImageAI: TFrmImageAI;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
implementation

uses
  SysUtils, Math,
  uTLH.Graphics,
  {$IF CompilerVersion >= 22}Vcl.Imaging.pngimage{$ELSE}PNGImage{$IFEND}
  ;

{$R *.dfm}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Constructor TProcessThread.Create( CreateSuspended : boolean = False );
begin
  inherited;
  fCrit   := TCriticalSection.Create;
  fOut    := TStringList.Create;
  fTime   := 0;
  fResult := 0;
  fCancel := False;
end;

destructor TProcessThread.Destroy;
begin
  fCrit.Free;
  fOut.free;
  inherited;
end;

procedure TProcessThread.ExecutePELine( const Line: string; var Aborted: Boolean; IsStatus : boolean );
begin
  fCrit.Enter;
  if fCancel then
    Aborted := True;
  fOut.Add( Line );
  fCrit.Leave;
end;

function TProcessThread.GetTime : Cardinal;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  fCrit.Enter;
  result := fTime;
  fCrit.Leave;
end;

function TProcessThread.GetOutput : String;
begin
  result := '';
  if NOT Assigned( self ) then
    Exit;

  fCrit.Enter;
  result := fOut.Text;
  fCrit.Leave;
end;

function TProcessThread.GetResult : Integer;
begin
  result := 0;
  if NOT Assigned( self ) then
    Exit;

  fCrit.Enter;
  result := fResult;
  fCrit.Leave;
end;

function TProcessThread.GetCancel : Boolean;
begin
  result := False;
  if NOT Assigned( self ) then
    Exit;

  fCrit.Enter;
  result := fCancel;
  fCrit.Leave;
end;

procedure TProcessThread.SetCancel( Value : Boolean );
begin
  if NOT Assigned( self ) then
    Exit;

  fCrit.Enter;
  fCancel := Value;
  fCrit.Leave;
end;

procedure TProcessThread.Execute;
var
  ID : Integer;
begin
  fData.FileNameIn1 := '';
  fData.FileNameIn2 := '';
  fData.FileNameOut := '';
  fData.Preview := False;
  fData.Overwrite := False;
  ID := 0;
  while NOT Terminated do
    begin
    fCrit.Enter;
    if ( ID < Length( fItems ) ) then
      begin
      fData := fItems[ ID ];
      Inc( ID )
      end
    else
      fCancel := False;    

    if fCancel AND ( fData.FileNameIn1 <> '' ) then
      begin
      SetLength( fItems, 0 );
      ID := 0;
      fResult := -1000;
      fOnComplete( Self, fData.FileNameOut, fResult );

      fData.FileNameIn1 := '';
      fData.FileNameIn2 := '';
      fData.FileNameOut := '';
      fData.Preview     := False;
      fData.Overwrite   := False;
      fCancel           := False;
      end
    else if ( ID = Length( fItems ) ) then
      begin
      SetLength( fItems, 0 );
      ID := 0;
      end;

    if ( fData.FileNameIn1 <> '' ) then
      begin
      fOut.Clear;
      fCancel := False;
      end;
    fCrit.Leave;

    if ( fData.FileNameIn1 <> '' ) then
      begin
      Process( fData );
      if fData.Preview then
        begin
        if Assigned( fOnPreview ) then
          fOnPreview( Self, fData.FileNameOut, fResult );
        fData.Preview := False;
        end;
      if Assigned( fOnComplete ) then
        fOnComplete( Self, fData.FileNameOut, fResult );

      fData.FileNameIn1 := '';
      fData.FileNameIn2 := '';
      fData.FileNameOut := '';
      fData.Preview     := False;
      fData.Overwrite   := False;      
      end
    else
      Sleep( 1 )
    end;
end;

procedure TProcessThread.Process( Data : TDataRecord );
const
  TEMPFILE = 'tmp.png';
var
  Tick  : Cardinal;
  S     : String;
  i, ID : Integer;
  BMP   : TBitmap;
  PNG   : {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND};
begin
  fResult := -103;
  if NOT FileExists( Data.FileNameIn1 ) then
    Exit;

  S := ExtractFileExt( Data.FileNameIn1 );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = S ) then
      begin
      ID := i;
      Break;
      end;
    end;
  bmp := nil;
  if ( ID < 0 ) then
    begin
    if NOT LoadImageToBitmap( Data.FileNameIn1, bmp ) then
      begin
      fResult := -102;
      Exit;
      end;

    PNG := {$IF CompilerVersion >= 22}TPNGImage{$ELSE}TPNGObject{$IFEND}.Create;
    PNG.Assign( bmp );
    Data.FileNameIn1 := ExtractFilePath( ParamStr( 0 ) ) + TEMPFILE;
    PNG.SaveToFile( Data.FileNameIn1 );

    bmp.free;
    bmp := nil;
    end;

  S := ExtractFileExt( Data.FileNameOut );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = S ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Data.FileNameOut := ChangeFileExt( Data.FileNameOut, SUPPORTED_FORMATS[ 0 ] )
  else
    S := '';

  if FileExists( Data.FileNameOut ) then
    begin
    if Data.Overwrite then
      begin
      if NOT DeleteFile( Data.FileNameOut ) then
        begin
        fResult := -101;
        Exit;
        end;
      end
    else
      begin
      fResult := -101;
      Exit;
      end;
    end;

  case Data.Data.Mode of
    dmWaifu2x_NCNN :
        begin // Waifu2x NCNN Vulkan
        Tick := GetTickCount;
        fResult := Waifu2x_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameOut,
                                        Data.Data.Waifu2x_NCNN.Model,
                                        Data.Data.Waifu2x_NCNN.Scale,
                                        Data.Data.Waifu2x_NCNN.Denoise,
                                        Data.Data.Waifu2x_NCNN.TTA,
                                        Data.Data.Waifu2x_NCNN.OFormat,
                                        True{Verbose},
                                        ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmRealSR_NCNN :
        begin // RealSR NCNN Vulkan
        Tick := GetTickCount;
        fResult := RealSR_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameOut,
                                       Data.Data.RealSR_NCNN.Model,
                                       Data.Data.RealSR_NCNN.TTA,
                                       Data.Data.RealSR_NCNN.OFormat,
                                       True{Verbose},
                                       ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmRealCugan_NCNN :
        begin // RealCugan NCNN Vulkan
        Tick := GetTickCount;
        fResult := RealCugan_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameOut,
                                          Data.Data.RealCugan_NCNN.Model,
                                          Data.Data.RealCugan_NCNN.Scale,
                                          Data.Data.RealCugan_NCNN.SyncGapMode,
                                          Data.Data.RealCugan_NCNN.TTA,
                                          Data.Data.RealCugan_NCNN.OFormat,
                                          True{Verbose},
                                          ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmRealEsrgan_NCNN :
        begin // RealEsrgan NCNN Vulkan
        Tick := GetTickCount;
        fResult := RealEsrgan_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameOut,
                                           Data.Data.RealEsrgan_NCNN.Model,
                                           Data.Data.RealEsrgan_NCNN.Scale,
                                           Data.Data.RealEsrgan_NCNN.TTA,
                                           Data.Data.RealEsrgan_NCNN.OFormat,
                                           True{Verbose},
                                           ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmSRMD_NCNN :
        begin // SRMD NCNN Vulkan
        Tick := GetTickCount;
        fResult := SRMD_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameOut,
                                     {TSRMD_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex ),}
                                     Data.Data.SRMD_NCNN.Scale,
                                     Data.Data.SRMD_NCNN.Denoise,
                                     Data.Data.SRMD_NCNN.TTA,
                                     Data.Data.SRMD_NCNN.OFormat,
                                     True{Verbose},
                                     ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmAnime4k :
        begin // Anime4k
        Tick := GetTickCount;
        fResult := Anime4k( Data.FileNameIn1, Data.FileNameOut,
                            Data.Data.Anime4k.Scale,
                            Data.Data.Anime4k.PreFilters,
                            Data.Data.Anime4k.PostFilters,
                            Data.Data.Anime4k.Passes,
                            Data.Data.Anime4k.PushColorCount,
                            Data.Data.Anime4k.StrengthColor,
                            Data.Data.Anime4k.StrengthGradient,
                            Data.Data.Anime4k.FastMode,
                            Data.Data.Anime4k.GPUMode,
                            Data.Data.Anime4k.CNNMode,
                            Data.Data.Anime4k.HDN,
                            Data.Data.Anime4k.HDNLevel,
                            Data.Data.Anime4k.NCNN,

                            ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmWaifu2x :
        begin // Waifu2x
        Tick := GetTickCount;
        fResult := Waifu2x( Data.FileNameIn1, Data.FileNameOut,
                            Data.Data.Waifu2x.Scale,
                            Data.Data.Waifu2x.Denoise,
                            Data.Data.Waifu2x.TTA,
                            Data.Data.Waifu2x.GPU,
                            Data.Data.Waifu2x.ForceOpenCL,
                            Data.Data.Waifu2x.PNGCompression,
                            Data.Data.Waifu2x.JPEG_WebPCompression,
                            Data.Data.Waifu2x.OFormat,
                            ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmWaifu2x_Caffe :
        begin // Waifu2x Caffe
        Tick := GetTickCount;
        fResult := Waifu2x_Caffe( Data.FileNameIn1, Data.FileNameOut,
                                  Data.Data.Waifu2x_Caffe.Model,
                                  Data.Data.Waifu2x_Caffe.ScaleWidth,
                                  Data.Data.Waifu2x_Caffe.ScaleHeight,
                                  Data.Data.Waifu2x_Caffe.ScaleRatio,
                                  Data.Data.Waifu2x_Caffe.CropWidth,
                                  Data.Data.Waifu2x_Caffe.CropHeight,
                                  Data.Data.Waifu2x_Caffe.CropDivisor,
                                  Data.Data.Waifu2x_Caffe.Denoise,
                                  Data.Data.Waifu2x_Caffe.Mode,
                                  Data.Data.Waifu2x_Caffe.TTA,
                                  Data.Data.Waifu2x_Caffe.ImageQuality,
                                  ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmCain :
        begin // Cain NCNN Vulkan
        Tick := GetTickCount;
        fResult := Cain_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameIn2, Data.FileNameOut, True{Verbose}, ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

    dmDain :
        begin // Dain NCNN Vulkan
        Tick := GetTickCount;
        fResult := Dain_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameIn2, Data.FileNameOut,
                                     Data.Data.Dain.FrameCount,
                                     Data.Data.Dain.TimeStep,
                                     Data.Data.Dain.TileSize,
                                     True{Verbose},
                                     ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

   dmIfrNet_NCNN :
        begin // IfrNet NCNN Vulkan
        Tick := GetTickCount;
        fResult := IfrNet_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameIn2, Data.FileNameOut,
                                       Data.Data.IfrNet_NCNN.Model,
                                       Data.Data.IfrNet_NCNN.TTA,
                                       Data.Data.IfrNet_NCNN.UltraHD,
                                       Data.Data.IfrNet_NCNN.FrameCount,
                                       Data.Data.IfrNet_NCNN.TimeStep,
                                       True{Verbose},
                                       ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

   dmRife_NCNN :
        begin // Rife NCNN Vulkan
        Tick := GetTickCount;
        fResult := Rife_NCNN_Vulkan( Data.FileNameIn1, Data.FileNameIn2, Data.FileNameOut,
                                     Data.Data.Rife_NCNN.Model,
                                     Data.Data.Rife_NCNN.TTA,
                                     Data.Data.Rife_NCNN.UltraHD,
                                     Data.Data.Rife_NCNN.FrameCount,
                                     Data.Data.Rife_NCNN.TimeStep,
                                     True{Verbose},
                                     ExecutePELine );
        fCrit.Enter;
        fTime := GetTickCount-Tick;
        fCrit.Leave;
        end;

  end;
  if ( ID < 0 ) AND FileExists( Data.FileNameIn1 ) then
    begin
    if FileExists( Data.FileNameOut ) then
      begin
      if LoadImageToBitmap( Data.FileNameOut, bmp ) then
        begin
        DeleteFile( Data.FileNameOut );
        Data.FileNameOut := ChangeFileExt( Data.FileNameOut, S );
        SaveImageFromBitmapByExtension( Data.FileNameOut, bmp );
        end;
      end;
    DeleteFile( Data.FileNameIn1 );
    end;
end;

procedure TProcessThread.AddItem( Data : TDataRecord );
begin
  fCrit.Enter;
  SetLength( fItems, Length( fItems )+1 );
  fItems[ High( fItems ) ] := Data;
  fCrit.Leave;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmImageAI.FormCreate(Sender: TObject);
begin
  fInWidth       := 0;
  fInHeight      := 0;
  fPreviewWidth  := 0;
  fPreviewHeight := 0;
  fPanning       := False;
  fPanningX      := Low( Integer );
  fPanningY      := Low( Integer );
  fPanningLX     := Low( Integer );
  fPanningLY     := Low( Integer );

  pgcModes.Align := alNone;
  pgcModes.Top   := pgcModes.Top-22;
  pgcModes.Height:= pgcModes.Height+22;

  pgcOutput.Align := alNone;
  pgcOutput.Top   := pgcOutput.Top-22;
//  pgcOutput.Height:= pgcOutput.Height+22;
  grpOutput.Height:= grpOutput.Height-22;
  rgOutputMode.BringToFront;

  imgIn.OnMouseWheel := imgMouseWheel;
  imgPreview.OnMouseWheel := imgMouseWheel;

  edtA4k_Scale.Text := Format( '%.2f', [ 2.0 ] ); // Adapt to OS-Decimal Seperator
  edtA4k_StrengthColor.Text := Format( '%.2f', [ 0.3 ] ); // Adapt to OS-Decimal Seperator
  edtWaifu2x_Scale.Text := Format( '%.2f', [ 2.0 ] ); // Adapt to OS-Decimal Seperator
  edtDain_TimeStep.Text := Format( '%.2f', [ 0.5 ] ); // Adapt to OS-Decimal Seperator

  dirEdtIn.Directory := ExtractFileDir( ParamStr( 0 ) );
  cbbModeChange( cbbMode );

  fThread := TProcessThread.Create;
  fThread.OnPreview  := OnPreview;
  fThread.OnComplete := OnComplete;

  fCrit := TCriticalSection.Create;
  fTimer  := TTimer.Create( self );
  fTimer.Interval := 100;
  fTimer.OnTimer := OnTimer;
  fTimer.Enabled := True;
  fPreviewFile := '';
end;

procedure TFrmImageAI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fTimer.Enabled := False;
end;

procedure TFrmImageAI.FormDestroy(Sender: TObject);
begin
//  fTimer.free;
  fCrit.free;
  fThread.Terminate;
  fThread.WaitFor;
  fThread.free;
end;

procedure TFrmImageAI.OnTimer(Sender: TObject);
var
  S : String;
begin
  fCrit.Enter;
  S := fPreviewFile;
  fPreviewFile := '';
  fCrit.Leave;
  if FileExists( S ) then
    begin
    LoadImage( S, FrmImageAI.imgPreview );
    DeleteFile( S );
    end;
end;

procedure TFrmImageAI.OnPreview(Sender: TObject; FileName : String; Result : Integer);
begin
  fCrit.Enter;
  fPreviewFile := FileName;
  fCrit.Leave;
end;

procedure TFrmImageAI.OnComplete(Sender: TObject; FileName : String; Result : Integer);
begin
  lblTime.Caption := Format( '%d ms', [ fThread.Time ] );
  mmoOutput.Lines.Add( fThread.Output );

  if ( {fThread.}Result <> 0 ) then
    begin
    mmoOutput.Lines.Add( Format( '%s returned error %d', [ FileName, {fThread.}result ] ) );
    fPreviewWidth := 0;
    fPreviewHeight := 0;
    end;

  pbProgress.Position := pbProgress.Position+1;
  lblProgress.Caption := Format( '%d / %d', [ pbProgress.Position, pbProgress.Max ] );
  pnlProgress.Visible := NOT fThread.Cancel AND ( pbProgress.Position < pbProgress.Max );
end;

procedure TFrmImageAI.dirEdtInChange(Sender: TObject);
begin
  if DirectoryExists( TJvDirectoryEdit( Sender ).Directory ) then
    begin
    flIn.Directory := TJvDirectoryEdit( Sender ).Directory;
    flIn.Update;
    end
  else
    flIn.Clear;
end;

procedure TFrmImageAI.BlockKeyPress(Sender: TObject; var Key: Char);
begin
  if ( Key = #1{SelectAll} ) then
    begin
    if ( Sender is TWinControl ) then
      TWinControl( Sender ).Perform( $00B1{EM_SETSEL}, WPARAM( 0 ){SelStart}, LPARAM( -1 ){SelEnd} ); // -1=SelectAll
    end
  else if NOT {$IF CompilerVersion >= 22}CharInSet( Key,{$ELSE}( Key in{$IFEND} [ #3{Copy}, #27{ESCAPE} ] ) then
    Key := #0;
end;

procedure TFrmImageAI.flInClick(Sender: TObject);
begin
  LoadImage( TFileListBox( Sender ).FileName, imgIn );
  OnChange( Sender );
end;

procedure TFrmImageAI.btnProcessClick(Sender: TObject);
var
  FileNameIn,
  FileNameOut : String;
  Data        : TDataRecord;
  i           : Integer;
begin
  if ( flIn.SelCount = 0 ) then
    Exit;

  case rgOutputMode.ItemIndex of
    0 : begin // Directory
        if NOT DirectoryExists( dirEdtOutput.Directory ) then
          begin
          if NOT ForceDirectories( dirEdtOutput.Directory ) then
            begin
            mmoOutput.Lines.Add( 'Unable to create directory: ' + dirEdtOutput.Directory );
            Exit;
            end;
          end;
        end;
    1 : begin // Sub-Directory
        if NOT DirectoryExists( IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + IncludeTrailingPathDelimiter( edtOutputSubDirectory.Text ) ) then
          begin
          if NOT ForceDirectories( IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + IncludeTrailingPathDelimiter( edtOutputSubDirectory.Text ) ) then
            begin
            mmoOutput.Lines.Add( 'Unable to create directory: ' + IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + IncludeTrailingPathDelimiter( edtOutputSubDirectory.Text ) );
            Exit;
            end;
          end;
        end;
    2 : begin // Edit
        end;
  else
    Exit;
  end;    

  mmoOutput.Clear;
  lblTime.Caption := '---';
  pbProgress.Position := 0;
  pnlProgress.Visible := True;
  pbProgress.Max := flIn.SelCount;
  lblProgress.Caption := Format( '%d / %d', [ pbProgress.Position, pbProgress.Max ] );

  if ( cbbMode.ItemIndex >= 8 ) AND ( flIn.SelCount = 2 ) then
    begin
    FileNameIn := '';
    for i := 0 to flIn.Items.Count-1 do
      begin
      if NOT flIn.Selected[ i ] then
        Continue;

      if ( FileNameIn = '' ) then
        FileNameIn := flIn.Items[ i ]
      else
        begin
        case rgOutputMode.ItemIndex of
          0 : begin // Directory
              FileNameOut := IncludeTrailingPathDelimiter( dirEdtOutput.Directory ) + FileNameIn;
              end;
          1 : begin // Sub-Directory
              FileNameOut := IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + IncludeTrailingPathDelimiter( edtOutputSubDirectory.Text ) + FileNameIn;
              end;
          2 : begin // Edit
              FileNameOut := IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + lbledtOutputPrefix.Text + ExtractFileName( ChangeFileExt( FileNameIn, '' ) ) + lbledtOutputSuffix.Text + ExtractFileExt( FileNameIn );
              end;
        else
          Break;
        end;
        if GetSettings( IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + FileNameIn, IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + flIn.Items[ i ], FileNameOut, Data ) then
          fThread.AddItem( Data );
        break;
        end;
      end;
    end
  else
    begin
    for i := 0 to flIn.Items.Count-1 do
      begin
      if NOT flIn.Selected[ i ] then
        Continue;

      case rgOutputMode.ItemIndex of
        0 : begin // Directory
            FileNameOut := IncludeTrailingPathDelimiter( dirEdtOutput.Directory ) + flIn.Items[ i ];
            end;
        1 : begin // Sub-Directory
            FileNameOut := IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + IncludeTrailingPathDelimiter( edtOutputSubDirectory.Text ) + flIn.Items[ i ];
            end;
        2 : begin // Edit
            FileNameOut := IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + lbledtOutputPrefix.Text + ExtractFileName( ChangeFileExt( flIn.Items[ i ], '' ) ) + lbledtOutputSuffix.Text + ExtractFileExt( flIn.Items[ i ] );
            end;
      else
        Break;
      end;

      if GetSettings( IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + flIn.Items[ i ], '', FileNameOut, Data ) then
        fThread.AddItem( Data );
      end;
    end;
end;

procedure TFrmImageAI.btnCancelClick(Sender: TObject);
begin
  fThread.Cancel := True;
end;

procedure TFrmImageAI.LoadImage( FileName : string; Image : TImage );
var
  S : String;
  bmp : TBitmap;
begin
  if NOT FileExists( FileName ) then
    Exit;
  S := LowerCase( ExtractFileExt( FileName ) );
  if ( S = '.tiff' ) OR ( S = '.tif' ) then
    begin
    bmp := TBitmap.Create;
    if ReadTiffToBitmap( FileName, bmp ) then
      Image.Picture.Assign( bmp );
    bmp.free;
    end
  else
    begin
    try
      Image.Picture.LoadFromFile( FileName );
    except
      Image.Picture.Graphic.Width := 0;
      Image.Picture.Graphic.Height := 0;
      if ( Image = imgPreview ) then
        begin
        fPreviewWidth := 0;
        fPreviewHeight := 0;
        end
      else
        begin
        fInWidth := 0;
        fInHeight := 0;
        end;
      Exit;
    end;
    end;
  if ( Image = imgPreview ) then
    begin
    fPreviewWidth := Image.Picture.Width;
    fPreviewHeight := Image.Picture.Height;
    end
  else
    begin
    fInWidth := Image.Picture.Width;
    fInHeight := Image.Picture.Height;
    end;

  if chkPreviewFit.Checked then
    begin
    if ( Image = imgIn ) then
      begin
      Image.Width  := Image.Parent.Width-4;
      Image.Height := Image.Parent.Height-4;
      end
    else
      begin
      Image.Width  := imgIn.Width;
      Image.Height := imgIn.Height;
      ScrlBoxPreview.HorzScrollBar.Position := ScrlBoxIn.HorzScrollBar.Position;
      ScrlBoxPreview.VertScrollBar.Position := ScrlBoxIn.VertScrollBar.Position;
      end;
    end
  else
    begin
    Image.Width  := Image.Picture.Width;
    Image.Height := Image.Picture.Height;
    end;
end;

procedure TFrmImageAI.OnChange(Sender: TObject);
const
  PREVIEW = 'Preview.jpg';
var
  FileName : string;
  Output   : string;
  Data     : TDataRecord;
  i        : Integer;
begin
  if NOT chkPreview.Checked then
    Exit;

  if ( cbbMode.ItemIndex >= 8 ) AND ( flIn.SelCount = 2 ) then
    begin

    end
  else
    begin
    FileName := flIn.FileName;
    if NOT FileExists( FileName ) then
      Exit;
    Output := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + ChangeFileExt( PREVIEW, ExtractFileExt( FileName ) );
    end;

  mmoOutput.Clear;
  lblTime.Caption := '---';
  pbProgress.Position := 0;
  pbProgress.Max := 1;
  pnlProgress.Visible := True;
  lblProgress.Caption := Format( '%d / %d', [ pbProgress.Position, pbProgress.Max ] );

  if ( cbbMode.ItemIndex >= 8 ) AND ( flIn.SelCount = 2 ) then
    begin
    FileName := '';
    Output     := '';
    for i := 0 to flIn.Items.Count-1 do
      begin
      if NOT flIn.Selected[ i ] then
        Continue;

      if ( FileName = '' ) then
        begin
        FileName := flIn.Items[ i ];
        Output   := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + ChangeFileExt( PREVIEW, ExtractFileExt( FileName ) );
        end
      else
        begin
        if GetSettings( IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + FileName, IncludeTrailingPathDelimiter( dirEdtIn.Directory ) + flIn.Items[ i ], Output, Data, True ) then
          fThread.AddItem( Data );
        break;
        end;
      end;
    end
  else
    begin
    if GetSettings( FileName, '', Output, Data, True ) then
      fThread.AddItem( Data );
    end;
  imgPreview.Picture.Bitmap.Width := 0;
end;

procedure TFrmImageAI.chkPreviewClick(Sender: TObject);
begin
  if TCheckBox( Sender ).Checked then
    begin
    rgPreviewClick( rgPreview );
    OnChange( Sender );
    end;
end;

procedure TFrmImageAI.UpdateImageDimension( Fit : Boolean );
begin
  if Fit then
    begin
    imgIn.Width := ScrlBoxIn.Width-4;
    imgIn.Height := ScrlBoxIn.Height-4;
    imgPreview.Width := ScrlBoxPreview.Width-4;
    imgPreview.Height := ScrlBoxPreview.Height-4;
    end
  else
    begin
    imgIn.Width := fInWidth;
    imgIn.Height := fInHeight;
    imgPreview.Width := fPreviewWidth;
    imgPreview.Height := fPreviewHeight;
    end
end;

procedure TFrmImageAI.chkPreviewFitClick(Sender: TObject);
begin
  UpdateImageDimension( TCheckBox( Sender ).Checked );
end;

procedure TFrmImageAI.rgPreviewClick(Sender: TObject);
begin
  case TRadioGroup( Sender ).ItemIndex of
    0 : begin
        splPreview.Visible     := True;
        ScrlBoxIn.Visible      := True;
        ScrlBoxPreview.Visible := True;
        ScrlBoxPreview.Align   := alRight;

        ScrlBoxPreview.Align := alLeft;
        ScrlBoxPreview.Width := pnlPreview.Width div 2;

        ScrlBoxIn.Align      := alLeft;
        ScrlBoxIn.Left       := 0;
        ScrlBoxIn.Width      := pnlPreview.Width div 2;

        splPreview.Align     := alLeft;
        splPreview.Left      := ScrlBoxPreview.Left-1;
        end;

    1 : begin
        splPreview.Visible     := True;
        ScrlBoxIn.Visible      := True;
        ScrlBoxPreview.Visible := True;
        ScrlBoxPreview.Align   := alRight;

        ScrlBoxPreview.Align  := alTop;
        ScrlBoxPreview.Height := pnlPreview.Height div 2;

        ScrlBoxIn.Align       := alTop;
        ScrlBoxIn.Top         := 0;
        ScrlBoxIn.Height      := pnlPreview.Height div 2;

        splPreview.Align      := alTop;
        splPreview.Top        := ScrlBoxPreview.Top-1;
        end;

    2, 3 :
        begin
        splPreview.Visible     := False;
        ScrlBoxIn.Align        := alClient;
        ScrlBoxIn.Visible      := True;
        ScrlBoxPreview.Visible := False;
        ScrlBoxPreview.Align   := alClient;
        splPreview.Visible     := False;
        end;
  end;

  UpdateImageDimension( chkPreviewFit.Checked );
end;

procedure TFrmImageAI.splPreviewMoved(Sender: TObject);
begin
  UpdateImageDimension( chkPreviewFit.Checked );
end;

procedure TFrmImageAI.FormResize(Sender: TObject);
begin
  if rgPreview.ItemIndex = 0 then
    begin
    ScrlBoxIn.Width      := pnlPreview.Width div 2;
    ScrlBoxPreview.Width := pnlPreview.Width div 2;
    splPreview.Left      := ScrlBoxPreview.Left-1
    end
  else if rgPreview.ItemIndex = 1 then
    begin
    ScrlBoxIn.Height      := pnlPreview.Height div 2;
    ScrlBoxPreview.Height := pnlPreview.Height div 2;
    splPreview.Top        := ScrlBoxPreview.Top-1;
    end;

  UpdateImageDimension( chkPreviewFit.Checked );
end;

procedure TFrmImageAI.FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
const
  {$J+}
  performing : boolean = false;
  {$J-}
var
  ctrl : TControl;
  wc : TWinControl;
begin
  Handled := false;

  if performing then
    Exit;

  wc := FindVCLWindow( MousePos );
  if NOT Assigned( wc ) then
    Exit;

  ctrl := wc.ControlAtPos( wc.ScreenToClient( MousePos ), false, false );
  if NOT Assigned(ctrl) then
    Exit;

  performing := true;
  try
    ctrl.Perform( CM_MOUSEWHEEL, WheelDelta, MakeLParam( MousePos.X, MousePos.Y ) );
  finally
    performing := false;
  end;
  Handled := true;
end;

procedure TFrmImageAI.btnFilesClick(Sender: TObject);
begin
  if ( pnlFiles.Width > TButton( Sender ).Width ) then
    begin
    TButton( Sender ).Caption := '>';
    pnlFiles.Tag   := pnlFiles.Width;
    pnlFiles.Width := TButton( Sender ).Width;
    end
  else
    begin
    TButton( Sender ).Caption := '<';
    pnlFiles.Width := pnlFiles.Tag;
    pnlFiles.Tag   := 0;
    end
end;

procedure TFrmImageAI.btnControlsClick(Sender: TObject);
begin
  if ( pnlControlsInflate.Width > TButton( Sender ).Width ) then
    begin
    TButton( Sender ).Caption := '>';
    pnlControlsInflate.Tag   := pnlControlsInflate.Width;
    pnlControlsInflate.Width := TButton( Sender ).Width;

    pnlControls.Tag   := pnlControls.Width;
    pnlControls.Width := 0;
    end
  else
    begin
    TButton( Sender ).Caption := '<';
    pnlControlsInflate.Width := pnlControlsInflate.Tag;
    pnlControlsInflate.Tag   := 0;

    pnlControls.Width := pnlControls.Tag;
    pnlControls.Tag   := 0;
    end
end;

procedure TFrmImageAI.rgOutputModeClick(Sender: TObject);
begin
  case TRadioGroup( Sender ).ItemIndex of
    0 : pgcOutput.ActivePage := tsOutputDirectory;
    1 : pgcOutput.ActivePage := tsOutputSubDirectory;
    2 : pgcOutput.ActivePage := tsOutputEdit;
  end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmImageAI.chkA4k_PreFiltersClick(Sender: TObject);
begin
  SetEnabledForControls( grpA4k_PreFilters, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.chkA4k_PostFiltersClick(Sender: TObject);
begin
  SetEnabledForControls( grpA4k_PostFilters, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.chkA4k_CNNModeClick(Sender: TObject);
begin
  SetEnabledForControls( grpA4k_CNNMode, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.chkA4k_HDNClick(Sender: TObject);
begin
  SetEnabledForControls( grpA4k_HDN, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.FloatUnsignedKeyPress(Sender: TObject; var Key: Char);
begin
  OnKeyPressCheckChar( Sender, Key, kpmFloatUnsigned );
end;

procedure TFrmImageAI.UnsignedKeyPress(Sender: TObject;
  var Key: Char);
begin
  OnKeyPressCheckChar( Sender, Key, kpmUnsigned );
end;

procedure TFrmImageAI.FloatUnsignedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  OnKeyDownManipulateNumbersViaUpDown( Sender, Key, Shift, kpmFloatUnsigned );
end;

procedure TFrmImageAI.UnsignedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  OnKeyDownManipulateNumbersViaUpDown( Sender, Key, Shift, kpmFloatUnsigned );
end;

procedure TFrmImageAI.edtA4k_StrengthKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmDouble;
  sets.MinD := 0;
  sets.MaxD := 1;

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.edtA4k_HDNLevelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmUnSigned;
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  sets.MinU := 0;
  sets.MaxU := 3;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.edtA4k_PassesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmUnSigned;
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  sets.MinU := 0;
  sets.MaxU := 65535;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.edtA4k_PushColorCountKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmUnSigned;
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  sets.MinU := 0;
  sets.MaxU := 65535;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.chkWaifu2x_ScaleClick(Sender: TObject);
begin
  SetEnabledForControls( grpWaifu2x_Scale, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.chkWaifu2x_DenoiseClick(Sender: TObject);
begin
  SetEnabledForControls( grpWaifu2x_Denoise, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

procedure TFrmImageAI.edtWaifu2x_PNGCompressionKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmUnSigned;
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  sets.MinU := 0;
  sets.MaxU := 9;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.edtWaifu2x_JPEGCompressionKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Sets : tOnKeyPressRangeLimitSettings;
begin
  sets.Mode := kplmUnSigned;
  {$IF CompilerVersion < 23}{$RANGECHECKS OFF}{$IFEND} // RangeCheck might cause Internal-Error C1118
  sets.MinU := 0;
  sets.MaxU := 101;
  {$IF CompilerVersion < 23}{$RANGECHECKS ON}{$IFEND} // RangeCheck might cause Internal-Error C1118

  OnKeyUpNumberRangeLimit( Sender, Key, sets );
end;

procedure TFrmImageAI.chkWaifu2x_Caffe_ScaleClick(Sender: TObject);
begin
  SetEnabledForControls( grpWaifu2x_Caffe_Scale, TCheckBox( Sender ).Checked );
  OnChange( Sender );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmImageAI.imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ( Button = mbLeft ) then
    begin
    if ( rgPreview.ItemIndex = 2 ) then
      begin
      if ( fPreviewWidth = 0 ) OR ( fPreviewHeight = 0 ) then
        Exit;

      ScrlBoxIn.Visible := False;
      ScrlBoxPreview.Visible := True;
      end
    else if ( rgPreview.ItemIndex = 3 ) then
      begin
      if ( fPreviewWidth = 0 ) OR ( fPreviewHeight = 0 ) then
        Exit;

      ScrlBoxIn.Visible := NOT ScrlBoxIn.Visible;
      ScrlBoxPreview.Visible := NOT ScrlBoxPreview.Visible;
      end;
    end
  else if ( Button = mbRight ) then
    begin
    fPanning   := ( Button = mbRight );
    fPanningX  := X;
    fPanningY  := Y;
    fPanningLX := X;
    fPanningLY := Y;
    end;
end;

procedure TFrmImageAI.imgMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ( rgPreview.ItemIndex = 2 ) AND ( Button = mbLeft ) then
    begin
    ScrlBoxIn.Visible := True;
    ScrlBoxPreview.Visible := False;
    end;

  if ( Button = mbRight ) then
    begin
    fPanning   := False;
    fPanningX  := Low( Integer );
    fPanningY  := Low( Integer );
    fPanningLX := Low( Integer );
    fPanningLY := Low( Integer );
    end;
end;

procedure TFrmImageAI.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  rX, rY : Integer;
  dX, dY : Integer;
begin
  if NOT fPanning then
    Exit;

  // AntiFlicker
  if ( ( X = fPanningX ) AND ( Y = fPanningY ) ) OR ( ( X = fPanningLX ) AND ( Y = fPanningLY ) ) then
    Exit;

  dX := fPanningX-X;
  dY := fPanningY-Y;
  fPanningLX := fPanningX;
  fPanningLY := fPanningY;
  fPanningX := X;
  fPanningY := Y;

  rX := TScrollBox( TImage( Sender ).Parent ).HorzScrollBar.Range-TScrollBox( TImage( Sender ).Parent ).Width;
  if ( rX > 0 ) then
    TScrollBox( TImage( Sender ).Parent ).HorzScrollBar.Position := TScrollBox( TImage( Sender ).Parent ).HorzScrollBar.Position + dX;
  rY := TScrollBox( TImage( Sender ).Parent ).VertScrollBar.Range-TScrollBox( TImage( Sender ).Parent ).Height;
  if ( rY > 0 ) then
    TScrollBox( TImage( Sender ).Parent ).VertScrollBar.Position := TScrollBox( TImage( Sender ).Parent ).VertScrollBar.Position + dY;

  if chkPreviewFit.Checked AND ( rgPreview.ItemIndex > 1 ) then
    begin
    if ( Sender = imgIn ) then
      begin
      ScrlBoxPreview.HorzScrollBar.Position := ScrlBoxIn.HorzScrollBar.Position;
      ScrlBoxPreview.VertScrollBar.Position := ScrlBoxIn.VertScrollBar.Position;
      end
    else
      begin
      ScrlBoxIn.HorzScrollBar.Position := ScrlBoxPreview.HorzScrollBar.Position;
      ScrlBoxIn.VertScrollBar.Position := ScrlBoxPreview.VertScrollBar.Position;
      end;
    end;
end;

procedure TFrmImageAI.imgMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
const
  SCALEFACTOR = 0.25;
  MinPixel = 20;
begin
  if ( TImage( Sender ).Picture.Width = 0 ) then
    Exit;
  if ( WheelDelta >= 0 ) then
    begin
    TImage( Sender ).Width  := Trunc( TImage( Sender ).Width * ( 1+SCALEFACTOR ) );
    TImage( Sender ).Height := Trunc( TImage( Sender ).Height * ( 1+SCALEFACTOR ) );
    end
  else
    begin
    TImage( Sender ).Width  := Max( MinPixel, Trunc( TImage( Sender ).Width * ( 1-SCALEFACTOR ) ) );
    TImage( Sender ).Height := Max( MinPixel, Trunc( TImage( Sender ).Height * ( 1-SCALEFACTOR ) ) );
    end;

  if chkPreviewFit.Checked AND ( rgPreview.ItemIndex > 1 ) then
    begin
    if ( Sender = imgIn ) then
      begin
      imgPreview.Width  := imgIn.Width;
      imgPreview.Height := imgIn.Height;
      end
    else
      begin
      imgIn.Width  := imgPreview.Width;
      imgIn.Height := imgPreview.Height;
      end;
    end;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TFrmImageAI.cbbModeChange(Sender: TObject);
const
  GRPHEIGHT = 144;
var
  i : Integer;
  ts : TScale;
begin
  case TComboBox( Sender ).ItemIndex of
    0..4 : pgcModes.ActivePage := tsWNCNN;
       5 : pgcModes.ActivePage := tsAnime4k;
       6 : pgcModes.ActivePage := tsWaifu2x;
       7 : pgcModes.ActivePage := tsWaifu2x_Caffe;
   8..11 : pgcModes.ActivePage := tsDain;
  else
    Exit;
  end;

  case TComboBox( Sender ).ItemIndex of
    0 : begin // Waifu2x NCNN Vulkan
        grpWNCNN.Caption := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];

        cbbWNCNN_Model.Clear;
        cbbWNCNN_Model.Items.Add( 'Cunet' );
        cbbWNCNN_Model.Items.Add( 'Upconv 7 (Anime Style)' );
        cbbWNCNN_Model.Items.Add( 'Upconf 7 (Photo)' );
        cbbWNCNN_Model.ItemIndex := 0;

        cbbWNCNN_Scale.Enabled   := True;
        cbbWNCNN_Denoise.Enabled := True;
        cbbWNCNN_Model.Enabled   := True;

        cbbWNCNN_Scale.Items.Clear;
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale1 ) ) );
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale2 ) ) );
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale4 ) ) );
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale8 ) ) );
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale16 ) ) );
        cbbWNCNN_Scale.Items.Add( IntToStr( Integer( scale32 ) ) );
        cbbWNCNN_Scale.ItemIndex := 1;

        while ( cbbWNCNN_Denoise.Items.Count > 5 ) do
          cbbWNCNN_Denoise.Items.Delete( 5 );

        if ( cbbWNCNN_Denoise.ItemIndex < 0 ) then
          cbbWNCNN_Denoise.ItemIndex := 1;

        grpWNCNN_SyncGapMode.Visible := False;
        grpWNCNN.Height := GRPHEIGHT-grpWNCNN_SyncGapMode.Height;
        end;

    1 : begin // RealSR NCNN Vulkan (Scale x4)
        grpWNCNN.Caption := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];

        cbbWNCNN_Model.Clear;
        cbbWNCNN_Model.Items.Add( 'DF2K' );
        cbbWNCNN_Model.Items.Add( 'DF2K JPEG' );
        cbbWNCNN_Model.ItemIndex := 0;

        cbbWNCNN_Scale.Enabled   := False;
        cbbWNCNN_Denoise.Enabled := False;
        cbbWNCNN_Model.Enabled   := True;

        grpWNCNN_SyncGapMode.Visible := False;
        grpWNCNN.Height := GRPHEIGHT-grpWNCNN_SyncGapMode.Height;
        end;

    2 : begin // RealCugan NCNN Vulkan
        grpWNCNN.Caption := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];

        cbbWNCNN_Model.Clear;
        cbbWNCNN_Model.Items.Add( 'ES' );
        cbbWNCNN_Model.Items.Add( 'Nose' );
        cbbWNCNN_Model.Items.Add( 'Pro' );
        cbbWNCNN_Model.ItemIndex := 0;

        cbbWNCNN_Scale.Items.Clear;
        for ts := scale1 to scale4 do
          cbbWNCNN_Scale.Items.Add( IntToStr( Integer( ts ) ) );
        cbbWNCNN_Scale.ItemIndex := 1;

        cbbWNCNN_Scale.Enabled   := True;
        cbbWNCNN_Denoise.Enabled := False;
        cbbWNCNN_Model.Enabled   := True;

        grpWNCNN_SyncGapMode.Visible := True;
        grpWNCNN.Height := GRPHEIGHT;
        end;

    3 : begin // RealEsrgan NCNN Vulkan
        grpWNCNN.Caption := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];

        cbbWNCNN_Model.Clear;
        cbbWNCNN_Model.Items.Add( 'ESRGAN-x4' );
        cbbWNCNN_Model.Items.Add( 'RealESR AnimeVideo v3-x2' );
        cbbWNCNN_Model.Items.Add( 'RealESR AnimeVideo v3-x3' );
        cbbWNCNN_Model.Items.Add( 'RealESR AnimeVideo v3-x4' );
        cbbWNCNN_Model.Items.Add( 'RealESRGAN x4plus Anime' );
        cbbWNCNN_Model.Items.Add( 'RealESRGAN x4plus' );
        cbbWNCNN_Model.Items.Add( 'RealESRGANv2 AnimeVideo xsx2' );
        cbbWNCNN_Model.Items.Add( 'RealESRGANv2 AnimeVideo xsx4' );
        cbbWNCNN_Model.Items.Add( 'RealESRNET x4plus' );
        cbbWNCNN_Model.ItemIndex := 0;

        cbbWNCNN_Scale.Items.Clear;
        for ts := scale2 to scale4 do
          cbbWNCNN_Scale.Items.Add( IntToStr( Integer( ts ) ) );
        cbbWNCNN_Scale.ItemIndex := 0;

        cbbWNCNN_Scale.Enabled   := False;
        cbbWNCNN_Denoise.Enabled := False;
        cbbWNCNN_Model.Enabled   := True;

        grpWNCNN_SyncGapMode.Visible := False;
        grpWNCNN.Height := GRPHEIGHT-grpWNCNN_SyncGapMode.Height;
        end;

    4 : begin // SRMD NCNN Vulkan
        grpWNCNN.Caption := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];

        cbbWNCNN_Model.Clear;
        cbbWNCNN_Scale.Enabled   := True;
        cbbWNCNN_Denoise.Enabled := True;
        cbbWNCNN_Model.Enabled   := False;

        cbbWNCNN_Scale.Items.Clear;
        for ts := scale2 to scale4 do
          cbbWNCNN_Scale.Items.Add( IntToStr( Integer( ts ) ) );
        cbbWNCNN_Scale.ItemIndex := 0;

        if ( cbbWNCNN_Denoise.Items.Count = 5 ) then
          begin
          for i := 4 to 10 do
            cbbWNCNN_Denoise.Items.Add( IntToStr( i ) );
          end;

        grpWNCNN_SyncGapMode.Visible := False;
        grpWNCNN.Height := GRPHEIGHT-grpWNCNN_SyncGapMode.Height;
        end;

    5 : begin // Anime4k

        end;

    6 : begin // Waifu2x

        end;

    7 : begin // Waifu2x Caffe

        end;

    8 : begin // Cain NCNN Vulkan
        grpDain.Visible := False;
        end;

    9 : begin // Dain NCNN Vulkan
        grpDain.Caption          := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];
        grpDain.Visible          := True;
        grpDain_TileSize.Visible := True;
        grpIfrNet_Model.Visible  := False;
        grpRife_Model.Visible    := False;
        chkDain_TTA.Visible      := False;
        chkDain_UltraHD.Visible  := False;
        end;

   10 : begin // IfrNet NCNN Vulkan
        grpDain.Caption          := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];
        grpDain.Visible          := True;
        grpDain_TileSize.Visible := False;
        grpIfrNet_Model.Visible  := True;
        grpRife_Model.Visible    := False;
        chkDain_TTA.Visible      := True;
        chkDain_UltraHD.Visible  := True;
        end;

   11 : begin // Rife NCNN Vulkan
        grpDain.Caption          := cbbMode.Items[ TComboBox( Sender ).ItemIndex ];
        grpDain.Visible          := True;
        grpDain_TileSize.Visible := False;
        grpIfrNet_Model.Visible  := False;
        grpRife_Model.Visible    := True;
        chkDain_TTA.Visible      := True;
        chkDain_UltraHD.Visible  := True;
        end;
  else
    Exit;
  end;

  OnChange( Sender );
end;

function TFrmImageAI.GetSettings( FileNameIn1, FileNameIn2, FileNameOut : String; var Data : TDataRecord; Preview : Boolean = False ) : Boolean;
var
  PF, POF : TA4kFilters;
begin
  result := False;
  FillChar( Data, SizeOf( Data ), 0 );
  if NOT FileExists( FileNameIn1 ) then
    Exit;

  Data.FileNameIn1 := FileNameIn1;
  Data.FileNameIn2 := FileNameIn2;
  Data.FileNameOut := FileNameOut;
  Data.Preview := Preview; // chkPreview.Checked;
  Data.Overwrite := chkOverwrite.Checked;

  case cbbMode.ItemIndex of
    0 : begin // Waifu2x NCNN Vulkan
        if ( cbbWNCNN_Denoise.ItemIndex < 0 ) OR ( cbbWNCNN_Scale.ItemIndex < 0 ) OR ( cbbWNCNN_Model.ItemIndex < 0 ) OR ( cbbWNCNN_Format.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmWaifu2x_NCNN;

        case StrToIntDef( cbbWNCNN_Scale.Text, 0 ) of
          1  : Data.Data.Waifu2x_NCNN.Scale := scale1;
          2  : Data.Data.Waifu2x_NCNN.Scale := scale2;
          4  : Data.Data.Waifu2x_NCNN.Scale := scale4;
          8  : Data.Data.Waifu2x_NCNN.Scale := scale8;
          16 : Data.Data.Waifu2x_NCNN.Scale := scale16;
          32 : Data.Data.Waifu2x_NCNN.Scale := scale32;
        else
          Exit;
        end;

        Data.Data.Waifu2x_NCNN.Model := TWaifu2x_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex );
        Data.Data.Waifu2x_NCNN.Denoise := StrToIntDef( cbbWNCNN_Denoise.Text, 0 );
        Data.Data.Waifu2x_NCNN.TTA := chkWNCNN_TTA.Checked;
        Data.Data.Waifu2x_NCNN.OFormat := TOutFormat( cbbWNCNN_Format );
        end;

    1 : begin // RealSR NCNN Vulkan
        if {( cbbWNCNN_Denoise.ItemIndex < 0 ) OR ( cbbWNCNN_Scale.ItemIndex < 0 ) OR} ( cbbWNCNN_Model.ItemIndex < 0 ) OR ( cbbWNCNN_Format.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmRealSR_NCNN;
        Data.Data.RealSR_NCNN.Model := TRealSR_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex );
        Data.Data.RealSR_NCNN.TTA := chkWNCNN_TTA.Checked;
        Data.Data.RealSR_NCNN.OFormat := TOutFormat( cbbWNCNN_Format );
        end;

    2 : begin // RealCugan NCNN Vulkan
        if {( cbbWNCNN_Denoise.ItemIndex < 0 ) OR} ( cbbWNCNN_Scale.ItemIndex < 0 ) OR ( cbbWNCNN_Model.ItemIndex < 0 ) OR ( cbbWNCNN_Format.ItemIndex < 0 ) OR ( cbbWNCNN_SyncGapMode.ItemIndex < 0 ) then
          Exit;

        case StrToIntDef( cbbWNCNN_Scale.Text, 0 ) of
          1  : Data.Data.RealCugan_NCNN.Scale := scale1;
          2  : Data.Data.RealCugan_NCNN.Scale := scale2;
          3  : Data.Data.RealCugan_NCNN.Scale := scale3;
          4  : Data.Data.RealCugan_NCNN.Scale := scale4;
        else
          Exit;
        end;

        Data.Data.Mode := dmRealCugan_NCNN;
        Data.Data.RealCugan_NCNN.Model := TRealCugan_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex );
        Data.Data.RealCugan_NCNN.SyncGapMode := StrToIntDef( cbbWNCNN_SyncGapMode.Text, 0 );
        Data.Data.RealCugan_NCNN.TTA := chkWNCNN_TTA.Checked;
        Data.Data.RealCugan_NCNN.OFormat := TOutFormat( cbbWNCNN_Format );
        end;

    3 : begin // RealEsrgan NCNN Vulkan
        if {( cbbWNCNN_Denoise.ItemIndex < 0 ) OR} ( cbbWNCNN_Scale.ItemIndex < 0 ) OR ( cbbWNCNN_Model.ItemIndex < 0 ) OR ( cbbWNCNN_Format.ItemIndex < 0 ) then
          Exit;

        case StrToIntDef( cbbWNCNN_Scale.Text, 0 ) of
          1  : Data.Data.RealEsrgan_NCNN.Scale := scale1;
          2  : Data.Data.RealEsrgan_NCNN.Scale := scale2;
          3  : Data.Data.RealEsrgan_NCNN.Scale := scale3;
          4  : Data.Data.RealEsrgan_NCNN.Scale := scale4;
        else
          Exit;
        end;

        Data.Data.Mode := dmRealEsrgan_NCNN;
        Data.Data.RealEsrgan_NCNN.Model := TRealEsrgan_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex );
        Data.Data.RealEsrgan_NCNN.TTA := chkWNCNN_TTA.Checked;
        Data.Data.RealEsrgan_NCNN.OFormat := TOutFormat( cbbWNCNN_Format );
        end;

    4 : begin // SRMD NCNN Vulkan
        if ( cbbWNCNN_Denoise.ItemIndex < 0 ) OR ( cbbWNCNN_Scale.ItemIndex < 0 ) OR {( cbbWNCNN_Model.ItemIndex < 0 ) OR }( cbbWNCNN_Format.ItemIndex < 0 ) then
          Exit;

        case StrToIntDef( cbbWNCNN_Scale.Text, 0 ) of
          1  : Data.Data.Waifu2x_NCNN.Scale := scale1;
          2  : Data.Data.Waifu2x_NCNN.Scale := scale2;
          4  : Data.Data.Waifu2x_NCNN.Scale := scale4;
        else
          Exit;
        end;

        Data.Data.Mode := dmSRMD_NCNN;
//        Data.Data.Waifu2x_NCNN.Model := TSRMD_NCNN_Vulkan_Model( cbbWNCNN_Model.ItemIndex );
        Data.Data.Waifu2x_NCNN.Denoise := StrToIntDef( cbbWNCNN_Denoise.Text, 0 );
        Data.Data.Waifu2x_NCNN.TTA := chkWNCNN_TTA.Checked;
        Data.Data.Waifu2x_NCNN.OFormat := TOutFormat( cbbWNCNN_Format );
        end;

    5 : begin // Anime4k
        Data.Data.Mode := dmAnime4k;

        PF := [];
        if chkA4k_PreFilters.Checked then
          begin
          if chkA4k_PreFiltersMedianBlur.Checked then
            PF := PF+[ apfMedianBlur ];
          if chkA4k_PreFiltersMeanBlur.Checked then
            PF := PF+[ apfMeanBlur ];
          if chkA4k_PreFiltersCasSharpening.Checked then
            PF := PF+[ apfCasSharpening ];
          if chkA4k_PreFiltersGaussianBlurWeak.Checked then
            PF := PF+[ apfGaussianBlurWeak ];
          if chkA4k_PreFiltersGaussianBlur.Checked then
            PF := PF+[ apfGaussianBlur ];
          if chkA4k_PreFiltersBilateralFilter.Checked then
            PF := PF+[ apfBilateralFilter ];
          if chkA4k_PreFiltersBilateralFilterFaster.Checked then
            PF := PF+[ apfBilateralFilterFaster ];
          end;

        POF := [];
        if chkA4k_PostFilters.Checked then
          begin
          if chkA4k_PostFiltersMedianBlur.Checked then
            POF := POF+[ apfMedianBlur ];
          if chkA4k_PostFiltersMeanBlur.Checked then
            POF := POF+[ apfMeanBlur ];
          if chkA4k_PostFiltersCasSharpening.Checked then
            POF := POF+[ apfCasSharpening ];
          if chkA4k_PostFiltersGaussianBlurWeak.Checked then
            POF := POF+[ apfGaussianBlurWeak ];
          if chkA4k_PostFiltersGaussianBlur.Checked then
            POF := POF+[ apfGaussianBlur ];
          if chkA4k_PostFiltersBilateralFilter.Checked then
            POF := POF+[ apfBilateralFilter ];
          if chkA4k_PostFiltersBilateralFilterFaster.Checked then
            POF := POF+[ apfBilateralFilterFaster ];
          end;

        Data.Data.Anime4k.Scale            := StrToFloatDef( edtA4k_Scale.Text, 1 );
        Data.Data.Anime4k.PreFilters       := PF;
        Data.Data.Anime4k.PostFilters      := POF;
        Data.Data.Anime4k.Passes           := StrToIntDef( edtA4k_Passes.Text, 2 );
        Data.Data.Anime4k.PushColorCount   := StrToIntDef( edtA4k_PushColorCount.Text, 2 );
        Data.Data.Anime4k.StrengthColor    := StrToFloatDef( edtA4k_StrengthColor.Text, 0.3 );
        Data.Data.Anime4k.StrengthGradient := StrToFloatDef( edtA4k_StrengthGradient.Text, 1 );
        Data.Data.Anime4k.FastMode         := chkA4k_FastMode.Checked;
        Data.Data.Anime4k.GPUMode          := chkA4k_GPUMode.Checked;
        Data.Data.Anime4k.CNNMode          := chkA4k_CNNMode.Checked;
        Data.Data.Anime4k.HDN              := chkA4k_HDN.Checked;
        Data.Data.Anime4k.HDNLevel         := StrToIntDef( edtA4k_HDNLevel.Text, 1 );
        Data.Data.Anime4k.NCNN             := chkA4k_NCNN.Checked;
        end;

    6 : begin // Waifu2x
        if ( cbbWaifu2x_Denoise.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmWaifu2x;

        if chkWaifu2x_Scale.Checked then
          Data.Data.Waifu2x.Scale := StrToFloatDef( edtWaifu2x_Scale.Text, 1 )
        else
          Data.Data.Waifu2x.Scale := 1;

        if chkWaifu2x_Denoise.Checked then
          Data.Data.Waifu2x.Denoise := StrToIntDef( cbbWaifu2x_Denoise.Text, -1 )+1
        else
          Data.Data.Waifu2x.Denoise := 0;

        Data.Data.Waifu2x.TTA := chkWaifu2x_TTA.Checked;
        Data.Data.Waifu2x.GPU := chkWaifu2x_GPU.Checked;
        Data.Data.Waifu2x.ForceOpenCL := chkWaifu2x_ForceOpenCL.Checked;
        Data.Data.Waifu2x.PNGCompression := StrToIntDef( edtWaifu2x_PNGCompression.Text, 0 );
        Data.Data.Waifu2x.JPEG_WebPCompression := StrToIntDef( edtWaifu2x_JPEGCompression.Text, 101 );
        Data.Data.Waifu2x.OFormat := TOutFormat( cbbWaifu2x_Format );
        end;

    7 : begin // Waifu2x Caffe
        if ( cbbWaifu2x_Caffe_Model.ItemIndex < 0 ) OR ( rgWaifu2x_Caffe_Mode.ItemIndex < 0 ) OR ( cbbWaifu2x_Caffe_Denoise.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmWaifu2x_Caffe;

        if chkWaifu2x_Caffe_Scale.Checked then
          Data.Data.Waifu2x_Caffe.ScaleRatio := StrToFloatDef( edtWaifu2x_Scale.Text, 1 )
        else
          Data.Data.Waifu2x_Caffe.ScaleRatio := 1;

        Data.Data.Waifu2x_Caffe.Model := tWaifu2x_Caffe_Models( cbbWaifu2x_Caffe_Model.ItemIndex );
        Data.Data.Waifu2x_Caffe.ScaleWidth := StrToIntDef( edtWaifu2x_Caffe_ScaleWidth.Text, 0 );
        Data.Data.Waifu2x_Caffe.ScaleHeight := StrToIntDef( edtWaifu2x_Caffe_ScaleHeight.Text, 0 );
        Data.Data.Waifu2x_Caffe.CropWidth := StrToIntDef( edtWaifu2x_Caffe_CropWidth.Text, 0 );
        Data.Data.Waifu2x_Caffe.CropHeight := StrToIntDef( edtWaifu2x_Caffe_CropHeight.Text, 0 );
        Data.Data.Waifu2x_Caffe.CropDivisor := StrToIntDef( edtWaifu2x_Caffe_CropDivisor.Text, 0 );
        Data.Data.Waifu2x_Caffe.Denoise := cbbWaifu2x_Caffe_Denoise.ItemIndex;
        Data.Data.Waifu2x_Caffe.Mode := tWaifu2x_Caffe_ProcessMode( rgWaifu2x_Caffe_Mode.ItemIndex );
        Data.Data.Waifu2x_Caffe.TTA := chkWaifu2x_Caffe_TTA.Checked;
        Data.Data.Waifu2x_Caffe.ImageQuality := StrToIntDef( edtWaifu2x_Caffe_ImageQuality.Text, -1 );
        end;

    8 : begin // Cain NCNN Vulkan
        Data.Data.Mode := dmCain;
        end;

    9 : begin // Dain NCNN Vulkan
        Data.Data.Mode := dmDain;
        Data.Data.Dain.FrameCount := StrToIntDef( edtDain_FrameCount.Text, 0 );
        Data.Data.Dain.TimeStep := StrToFloatDef( edtDain_TimeStep.Text, 0.5 );
        Data.Data.Dain.TileSize := StrToIntDef( edtDain_TileSize.Text, 0 );
        end;

   10 : begin // IfrNet NCNN Vulkan
        if ( cbbIfrNet_Model.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmIfrNet_NCNN;
        Data.Data.IfrNet_NCNN.Model := TIfrNet_NCNN_Vulkan_Model( cbbIfrNet_Model.ItemIndex );
        Data.Data.IfrNet_NCNN.TTA := chkDain_TTA.Checked;
        Data.Data.IfrNet_NCNN.UltraHD := chkDain_UltraHD.Checked;
        Data.Data.IfrNet_NCNN.FrameCount := StrToIntDef( edtDain_FrameCount.Text, 0 );
        Data.Data.IfrNet_NCNN.TimeStep := StrToFloatDef( edtDain_TimeStep.Text, 0.5 );
        end;

   11 : begin // Rife NCNN Vulkan
        if ( cbbRife_Model.ItemIndex < 0 ) then
          Exit;
        Data.Data.Mode := dmRife_NCNN;
        Data.Data.Rife_NCNN.Model := TRife_NCNN_Vulkan_Model( cbbRife_Model.ItemIndex );
        Data.Data.Rife_NCNN.TTA := chkDain_TTA.Checked;
        Data.Data.Rife_NCNN.UltraHD := chkDain_UltraHD.Checked;
        Data.Data.Rife_NCNN.FrameCount := StrToIntDef( edtDain_FrameCount.Text, 0 );
        Data.Data.Rife_NCNN.TimeStep := StrToFloatDef( edtDain_TimeStep.Text, 0.5 );
        end;
  else
    Exit;
  end;
  result := True;
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
