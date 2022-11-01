unit uImageAI;

interface

uses
  uTLH.SysUtils;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
type
  TScale = (
    scale1 = 1,
    scale2 = 2,
    scale3 = 3, // SRMD
    scale4 = 4,
    scale8 = 8,
    scale16 = 16,
    scale32 = 32
  );

  TOutFormat = (
    ofInput,
    ofJPG,
    ofPNG,
    ofWebP
  );

const
  SUPPORTED_FORMATS : Array [ 0..3 ] of String = ( '.jpg', '.jpeg', '.png', '.webp' );
  INDIRECT_FORMATS  : Array [ 0..3 ] of String = ( '.bmp', '.tif', '.tiff', {'.gif',} 'tga' );

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Waifu2x NCNN Vulkan
type
  TWaifu2x_NCNN_Vulkan_Model = (
    wmCunet,
    wmUpConf7_AnimeStyle,
    wmUpConf7_Photo
  );

  TWaifu2x_NCNN_Vulkan_Settings = packed record
    Model : TWaifu2x_NCNN_Vulkan_Model;
    Scale : TScale;
    Denoise : Integer;
    TTA : Boolean;
    OFormat : TOutFormat;
  end;

function Waifu2x_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TWaifu2x_NCNN_Vulkan_Model = wmCunet; Scale : TScale = scale2; Denoise : Integer = 0; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

// RealSR NCNN Vulkan
type
  TRealSR_NCNN_Vulkan_Model = (
    rsrmDF2K,
    rsrmDF2K_JPEG
  );

  TRealSR_NCNN_Vulkan_Settings = packed record
    Model : TRealSR_NCNN_Vulkan_Model;
    TTA : Boolean;
    OFormat : TOutFormat;
  end;

function RealSR_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealSR_NCNN_Vulkan_Model = rsrmDF2K; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

// SRMD NCNN Vulkan
type
  TSRMD_NCNN_Vulkan_Settings = packed record
//    Model : SRMD_NCNN_Vulkan_Model;
    Scale : TScale;
    Denoise : Integer;
    TTA : Boolean;
    OFormat : TOutFormat;
  end;

function SRMD_NCNN_Vulkan( FileNameIn, FileNameOut : String; {Model : SRMD_NCNN_Vulkan_Model = rsrmDF2K;} Scale : TScale = scale2; Denoise : Integer = 0; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

// RealEsrgan NCNN Vulkan
type
  TRealEsrgan_NCNN_Vulkan_Model = (
    renvAnimeVideo,
    renvESRGAN_X4Plus,
    renvX4Plus_Anime,
    renvESRNET_X4Plus
  );

  TRealEsrgan_NCNN_Vulkan_Settings = packed record
    Model : TRealEsrgan_NCNN_Vulkan_Model;
    Scale : TScale;
    TTA : Boolean;
    OFormat : TOutFormat;
  end;

function RealEsrgan_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealEsrgan_NCNN_Vulkan_Model = renvAnimeVideo; Scale : TScale = scale2; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

// RealCugan NCNN Vulkan
type
  TRealCugan_NCNN_Vulkan_Model = (
    rcnvSE,
    rcnvNose,
    rcnvPro
  );

  TRealCugan_NCNN_Vulkan_Settings = packed record
    Model : TRealCugan_NCNN_Vulkan_Model;
    Scale : TScale;
    SyncGapMode : Byte;
    TTA : Boolean;
    OFormat : TOutFormat;
  end;

function RealCugan_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealCugan_NCNN_Vulkan_Model = rcnvSE; Scale : TScale = scale2; SyncGapMode : Byte = 3; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

type
  TA4kFilter = (
    apfMedianBlur,
    apfMeanBlur,
    apfCasSharpening,
    apfGaussianBlurWeak,
    apfGaussianBlur,
    apfBilateralFilter,
    apfBilateralFilterFaster
  );
  TA4kFilters = set of TA4kFilter;

  TA4k_Settings = packed record
    Scale            : Double;
    PreFilters       : TA4kFilters;
    PostFilters      : TA4kFilters;
    Passes           : Word;
    PushColorCount   : Word;
    StrengthColor    : Double;  
    StrengthGradient : Double;  
    FastMode         : Boolean; 
    GPUMode          : Boolean; 
    CNNMode          : Boolean; 
    HDN              : Boolean;
    HDNLevel         : Byte;
    NCNN             : Boolean;
  end;

function Anime4k( FileNameIn       : String;
                  FileNameOut      : String;
                  Scale            : Double = 2;      // zoom factor for resizing (double [=2])
                  PreFilters       : TA4kFilters = [ apfCasSharpening ];
                  PostFilters      : TA4kFilters = [ apfCasSharpening, apfBilateralFilter];
                  Passes           : Word = 2;        // Passes for processing (int [=2])
                  PushColorCount   : Word = 2;        // Limit the number of color pushes (int [=2])
                  StrengthColor    : Double = 0.3;    // Strength for pushing color,range 0 to 1,higher for thinner (double [=0.3])
                  StrengthGradient : Double = 1;      // Strength for pushing gradient,range 0 to 1,higher for sharper (double [=1])
                  FastMode         : Boolean = False; // Faster but maybe low quality
                  GPUMode          : Boolean = True;  // Enable GPU acceleration
                  CNNMode          : Boolean = False; // Enable ACNet
                  HDN              : Boolean = False; // Enable HDN mode for ACNet
                  HDNLevel         : Byte = 1;        // Set HDN level (int [=1])
                  NCNN             : Boolean = False; // Open ncnn and ACNet
                  ExecuteProc      : TExecutePELine = nil ) : Integer;

// Waifu2x
type
  TWaifu2x_Settings = packed record
    Scale : Double;
    Denoise : Word;
    TTA : Boolean;
    GPU : Boolean;
    ForceOpenCL : Boolean;
    PNGCompression : Byte;
    JPEG_WebPCompression : Byte;
    OFormat : TOutFormat;
  end;

function Waifu2x( FileNameIn, FileNameOut : String;
                  Scale : Double = 2;
                  Denoise : Word = 0;                // Denoise 0=Off, 1..4
                  TTA : Boolean = False;             // Enable Test-Time Augmentation mode.
                  GPU : Boolean = True;
                  ForceOpenCL : Boolean = False;     // force to use OpenCL on Intel Platform
                  PNGCompression : Byte = 0;         // Set PNG compression level (0-9), 9 = Max compression (slowest & smallest)
                  JPEG_WebPCompression : Byte = 101; // JPEG & WebP Compression quality (0-101, 0 being smallest size and lowest quality), use 101 for lossless WebP
                  OFormat : TOutFormat = ofInput;
                  ExecuteProc : TExecutePELine = nil ) : Integer;

// Waifu2x Caffe
type
  tWaifu2x_Caffe_ProcessMode = ( wcpmCPU, wcpmGPU, wcpmCudnn );

  tWaifu2x_Caffe_Models = (
    wcmCunet,
    wcmAnimeStyleArtRGB,
    wcmAnimeStyleArt,
    wcmPhoto,
    wcmUpConv7_AnimeStyleArtRGB,
    wcmUpConv7_Photo,
    wcmUpResNet10,
    wcmUkBench
  );

  TWaifu2x_Caffe_Settings = packed record
    Model : tWaifu2x_Caffe_Models;
    ScaleWidth : Cardinal;
    ScaleHeight : Cardinal;
    ScaleRatio : Double;
    CropWidth : Word;
    CropHeight : Word;
    CropDivisor : Word;
    Denoise : Word;
    Mode : tWaifu2x_Caffe_ProcessMode;
    TTA : Boolean;
    ImageQuality : Integer;
  end;

function Waifu2x_Caffe( FileNameIn, FileNameOut : String;
                        Model : tWaifu2x_Caffe_Models = wcmCunet;
                        ScaleWidth : Cardinal = 0;
                        ScaleHeight : Cardinal = 0;
                        ScaleRatio : Double = 1;
                        CropWidth : Word = 0;
                        CropHeight : Word = 0;
                        CropDivisor : Word = 128;          // Specify the division size. The default value is `128`
                        Denoise : Word = 0;                // Denoise 0=Off, 1=Auto, 2..5
                        Mode : tWaifu2x_Caffe_ProcessMode = wcpmGPU;
                        TTA : Boolean = False;             // Enable Test-Time Augmentation mode
                        ImageQuality : Integer = -1;
                        ExecuteProc : TExecutePELine = nil ) : Integer;

// Cain NCNN Vulkan
function Cain_NCNN_Vulkan( FileNameIn1, FileNameIn2, FileNameOut : String; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;

// Dain NCNN Vulkan
type
  TDain_Settings = packed record
    FrameCount : Cardinal;  
    TimeStep : Double;
    TileSize : Word;
  end;

function Dain_NCNN_Vulkan( FileNameIn1,
                           FileNameIn2,
                           FileNameOut : String;
                           FrameCount : Cardinal = 0;
                           TimeStep : Double = 0.5;
                           TileSize : Word = 256;
                           Verbose : Boolean = False;
                           ExecuteProc : TExecutePELine = nil ) : Integer;

// IfrNet NCNN Vulkan
type
  TIfrNet_NCNN_Vulkan_Model = (
    imVimeo90K,
    imVimeo90K_S,
    imVimeo90K_L,
    imGoPro,
    imGoPro_S,
    imGoPro_L
  );

  TIfrNet_NCNN_Vulkan_Settings = packed record
    Model : TIfrNet_NCNN_Vulkan_Model;
    TTA : Boolean;
    UltraHD : Boolean;
    FrameCount : Cardinal;
    TimeStep : Double;
  end;

function IfrNet_NCNN_Vulkan( FileNameIn1,
                             FileNameIn2,
                             FileNameOut : String;
                             Model : TIfrNet_NCNN_Vulkan_Model = imVimeo90K;
                             TTA : Boolean = False;
                             UltraHD : Boolean = False;
                             FrameCount : Cardinal = 0;
                             TimeStep : Double = 0.5;
                             Verbose : Boolean = False;
                             ExecuteProc : TExecutePELine = nil ) : Integer;

// Rife NCNN Vulkan
type
  TRife_NCNN_Vulkan_Model = (
    rmRife,
    rmRifeAnime,
    rmRifeHD,
    rmRifeUHD,
    rmRife2,
    rmRife2_3,
    rmRife2_4,
    rmRife3_0,
    rmRife3_1,
    rmRife4
  );

  TRife_NCNN_Vulkan_Settings = packed record
    Model : TRife_NCNN_Vulkan_Model;
    TTA : Boolean;
    UltraHD : Boolean;
    FrameCount : Cardinal;
    TimeStep : Double;
  end;

function Rife_NCNN_Vulkan( FileNameIn1,
                             FileNameIn2,
                             FileNameOut : String;
                             Model : TRife_NCNN_Vulkan_Model = rmRife2_3;
                             TTA : Boolean = False;
                             UltraHD : Boolean = False;
                             FrameCount : Cardinal = 0;
                             TimeStep : Double = 0.5;
                             Verbose : Boolean = False;
                             ExecuteProc : TExecutePELine = nil ) : Integer;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                             
type
  TDataMode = (
    dmUndefined = 0,
    dmWaifu2x_NCNN,
    dmRealSR_NCNN,
    dmSRMD_NCNN,
    dmRealEsrgan_NCNN,
    dmRealCugan_NCNN,
    dmAnime4k,
    dmWaifu2x,
    dmWaifu2x_Caffe,
    dmCain,
    dmDain,
    dmIfrNet_NCNN,
    dmRife_NCNN
  );

  TDataRecordUnion = packed record
    Mode : TDataMode;  
    case Integer of
      0 : ( Waifu2x_NCNN : TWaifu2x_NCNN_Vulkan_Settings );
      1 : ( RealSR_NCNN : TRealSR_NCNN_Vulkan_Settings );
      2 : ( SRMD_NCNN : TSRMD_NCNN_Vulkan_Settings );
      3 : ( RealEsrgan_NCNN : TRealEsrgan_NCNN_Vulkan_Settings );
      4 : ( RealCugan_NCNN : TRealCugan_NCNN_Vulkan_Settings );
      5 : ( Anime4k : TA4k_Settings );
      6 : ( Waifu2x : TWaifu2x_Settings );
      7 : ( Waifu2x_Caffe : TWaifu2x_Caffe_Settings );
//      8 : ; // Cain
      9 : ( Dain : TDain_Settings );
     10 : ( IfrNet_NCNN : TIfrNet_NCNN_Vulkan_Settings );
     11 : ( Rife_NCNN : TRife_NCNN_Vulkan_Settings );
  end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
implementation

uses
  SysUtils;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{
type
  TWaifu2x_NCNN_Vulkan_Model = (
    wmCunet,
    wmUpConf7_AnimeStyle,
    wmUpConf7_Photo
  );
}
function Waifu2x_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TWaifu2x_NCNN_Vulkan_Model = wmCunet; Scale : TScale = scale2; Denoise : Integer = 0; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'waifu2x-ncnn-vulkan\waifu2x-ncnn-vulkan.exe';
  Models : Array [ 0..2 ] of String = (
    'models-cunet',
    'models-upconv_7_anime_style_art_rgb',
    'models-upconv_7_photo'
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Denoise < -1 ) then
    Denoise := -1
  else if ( Denoise > 3 ) then
    Denoise := 3;

  if ( Scale = scale3 ) then
    Scale := scale4;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" -s %d -n %d -model-path "%s"', [ FileNameIn, FileNameOut, Integer( Scale ), Denoise, Models[ Integer( Model ) ] ] );

  case OFormat of
    ofJPG  : Params := Params + ' -f jpg';
    ofPNG  : Params := Params + ' -f png';
    ofWebP : Params := Params + ' -f webp';
  end;

  if TTA then
    Params := Params + ' -x';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

{
type
  TRealSR_NCNN_Vulkan_Model = (
    rsrmDF2K,
    rsrmDF2K_JPEG
  );
}
function RealSR_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealSR_NCNN_Vulkan_Model = rsrmDF2K; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'realsr-ncnn-vulkan\realsr-ncnn-vulkan.exe';
  Models : Array [ 0..1 ] of String = (
    'models-DF2K',
    'models-DF2K_JPEG'
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" -model-path "%s"', [ FileNameIn, FileNameOut, Models[ Integer( Model ) ] ] );

  case OFormat of
    ofJPG  : Params := Params + ' -f jpg';
    ofPNG  : Params := Params + ' -f png';
    ofWebP : Params := Params + ' -f webp';
  end;

  if TTA then
    Params := Params + ' -x';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

function SRMD_NCNN_Vulkan( FileNameIn, FileNameOut : String; {Model : SRMD_NCNN_Vulkan_Model = rsrmDF2K;} Scale : TScale = scale2; Denoise : Integer = 0; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'srmd-ncnn-vulkan\srmd-ncnn-vulkan.exe';
  Models : Array [ 0..0 ] of String = (
    'models-srmd'
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Denoise < -1 ) then
    Denoise := -1
  else if ( Denoise > 10 ) then
    Denoise := 10;

  if ( Scale > Scale4 ) then
    Scale := Scale4;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" -s %d -n %d -model-path "%s"', [ FileNameIn, FileNameOut, Integer( Scale ), Denoise, Models[ 0 ] ] );

  case OFormat of
    ofJPG  : Params := Params + ' -f jpg';
    ofPNG  : Params := Params + ' -f png';
    ofWebP : Params := Params + ' -f webp';
  end;

  if TTA then
    Params := Params + ' -x';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

{
type
  TRealEsrgan_NCNN_Vulkan_Model = (
    renvAnimeVideo,
    renvESRGAN_X4Plus,
    renvX4Plus_Anime,
    renvESRNET_X4Plus
  );
}
function RealEsrgan_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealEsrgan_NCNN_Vulkan_Model = renvAnimeVideo; Scale : TScale = scale2; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'RealEsrgan-ncnn-vulkan\RealEsrgan-ncnn-vulkan.exe';
  ModelDir = 'models';
  Models : Array [ 0..8 ] of String = (
    'esrgan-x4',
    'realesr-animevideov3-x2',
    'realesr-animevideov3-x3',
    'realesr-animevideov3-x4',
    'realesrgan-x4plus-anime',
    'realesrgan-x4plus',
    'RealESRGANv2-animevideo-xsx2',
    'RealESRGANv2-animevideo-xsx4',
    'realesrnet-x4plus'
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Scale > Scale4 ) then
    Scale := Scale4;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" -s %d model-path "%s" -model-name "\%s"', [ FileNameIn, FileNameOut, Integer( Scale ), ModelDir, Models[ Integer( Model ) ] ] );

  case OFormat of
    ofJPG  : Params := Params + ' -f jpg';
    ofPNG  : Params := Params + ' -f png';
    ofWebP : Params := Params + ' -f webp';
  end;

  if TTA then
    Params := Params + ' -x';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

{
type
  TRealCugan_NCNN_Vulkan_Model = (
    rcnvSE,
    rcnvNose,
    rcnvPro
  );
}
function RealCugan_NCNN_Vulkan( FileNameIn, FileNameOut : String; Model : TRealCugan_NCNN_Vulkan_Model = rcnvSE; Scale : TScale = scale2; SyncGapMode : Byte = 3; TTA : Boolean = False; OFormat : TOutFormat = ofInput; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'RealCugan-ncnn-vulkan\RealCugan-ncnn-vulkan.exe';
  Models : Array [ 0..2 ] of String = (
    'models-se',
    'models-nose',
    'models-pro'    
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Scale > Scale4 ) then
    Scale := Scale4;
    
  if ( SyncGapMode > 3 ) then
    SyncGapMode := 3;  

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" -s %d -c %d -model-name "\%s"', [ FileNameIn, FileNameOut, Integer( Scale ), SyncGapMode, Models[ Integer( Model ) ] ] );

  case OFormat of
    ofJPG  : Params := Params + ' -f jpg';
    ofPNG  : Params := Params + ' -f png';
    ofWebP : Params := Params + ' -f webp';
  end;
  if TTA then
    Params := Params + ' -x';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Anime4k
{
type
  TA4kFilter = (
    apfMedianBlur,
    apfMeanBlur,
    apfCasSharpening,
    apfGaussianBlurWeak,
    apfGaussianBlur,
    apfBilateralFilter,
    apfBilateralFilterFaster
  );
  TA4kFilters = set of TA4kFilter;
}
function Anime4k( FileNameIn       : String;
                  FileNameOut      : String;
                  Scale            : Double = 2;      // zoom factor for resizing (double [=2])
                  PreFilters       : TA4kFilters = [ apfCasSharpening ];
                  PostFilters      : TA4kFilters = [ apfCasSharpening, apfBilateralFilter];
                  Passes           : Word = 2;        // Passes for processing (int [=2]) 
                  PushColorCount   : Word = 2;        // Limit the number of color pushes (int [=2])
                  StrengthColor    : Double = 0.3;    // Strength for pushing color,range 0 to 1,higher for thinner (double [=0.3])
                  StrengthGradient : Double = 1;      // Strength for pushing gradient,range 0 to 1,higher for sharper (double [=1])
                  FastMode         : Boolean = False; // Faster but maybe low quality
                  GPUMode          : Boolean = True;  // Enable GPU acceleration
                  CNNMode          : Boolean = False; // Enable ACNet
                  HDN              : Boolean = False; // Enable HDN mode for ACNet
                  HDNLevel         : Byte = 1;        // Set HDN level (int [=1])
                  NCNN             : Boolean = False; // Open ncnn and ACNet
                  ExecuteProc      : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'Anime4k\Anime4k.exe';
  Models : Array [ 0..0 ] of String = (
    'models'
  );
var
  FileName : String;
  Params   : String;
  i, ID    : Integer;
  B        : Boolean;
  LF       : TFormatSettings;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  result := -103;
  Params := LowerCase( ExtractFileExt( FileNameIn ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  result := -102;
  Params := LowerCase( ExtractFileExt( FileNameOut ) );
  ID := -1;
  for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
    begin
    if ( SUPPORTED_FORMATS[ i ] = Params ) then
      begin
      ID := i;
      Break;
      end;
    end;
  if ( ID < 0 ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Scale = 0 ) then
    Scale := 1;

  if ( StrengthColor < 0 ) then
    StrengthColor := 0
  else if ( StrengthColor > 1 ) then
    StrengthColor := 1;

  if ( StrengthGradient < 0 ) then
    StrengthGradient := 0
  else if ( StrengthGradient > 1 ) then
    StrengthGradient := 1;

  if ( HDNLevel > 3 ) then
    HDNLevel := 3;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;

  GetLocaleFormatSettings( 0, LF );
  LF.DecimalSeparator := '.';
  Params := Format( '--input "%s" --output "%s" --zoomFactor %.2f --passes %d --pushColorCount %d --strengthColor %.2f --strengthGradient %.2f --ncnnModelPath "./%s"', [ FileNameIn, FileNameOut, Scale, Passes, PushColorCount, StrengthColor, StrengthGradient, Models[ 0 ] ], LF );

  if ( PreFilters <> [] ) then
    begin
    I := 0;
    if ( apfMedianBlur in PreFilters ) then
      I := I OR 1;
    if ( apfMeanBlur in PreFilters ) then
      I := I OR 2;
    if ( apfCasSharpening in PreFilters ) then
      I := I OR 4;
    if ( apfGaussianBlurWeak in PreFilters ) then
      I := I OR 8;
    if ( apfGaussianBlur in PreFilters ) then
      I := I OR 16;
    if ( apfBilateralFilter in PreFilters ) then
      I := I OR 32;
    if ( apfBilateralFilterFaster in PreFilters ) then
      I := I OR 64;

    Params := Params + Format( ' --preprocessing --preFilters %d', [ I ] );
    end;

  if ( PostFilters <> [] ) then
    begin
    I := 0;
    if ( apfMedianBlur in PostFilters ) then
      I := I OR 1;
    if ( apfMeanBlur in PostFilters ) then
      I := I OR 2;
    if ( apfCasSharpening in PostFilters ) then
      I := I OR 4;
    if ( apfGaussianBlurWeak in PostFilters ) then
      I := I OR 8;
    if ( apfGaussianBlur in PostFilters ) then
      I := I OR 16;
    if ( apfBilateralFilter in PostFilters ) then
      I := I OR 32;
    if ( apfBilateralFilterFaster in PostFilters ) then
      I := I OR 64;

    Params := Params + Format( ' --postprocessing --postFilters %d', [ I ] );
    end;

  if FastMode then
    Params := Params + ' --fastMode';

  if GPUMode then
    Params := Params + ' --GPUMode';

  if CNNMode then
    begin
    Params := Params + ' --CNNMode';
    if HDN then
      Params := Params + Format( ' --HDN --HDNLevel %d', [ HDNLevel ] );
    end;

  if NCNN then
    Params := Params + ' --ncnn';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Waifu2x
function Waifu2x( FileNameIn, FileNameOut : String;
                  Scale : Double = 2;
                  Denoise : Word = 0;                // Denoise 0=Off, 1..4
                  TTA : Boolean = False;             // Enable Test-Time Augmentation mode
                  GPU : Boolean = True;
                  ForceOpenCL : Boolean = False;     // Force to use OpenCL on Intel Platform
                  PNGCompression : Byte = 0;         // Set PNG compression level (0-9), 9 = Max compression (slowest & smallest)
                  JPEG_WebPCompression : Byte = 101; // JPEG & WebP Compression quality (0-101, 0 being smallest size and lowest quality), use 101 for lossless WebP
                  OFormat : TOutFormat = ofInput;
                  ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'waifu2x-converter\waifu2x-converter-cpp.exe';
  Models : Array [ 0..0 ] of String = (
    'models_rgb'  
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;
  LF       : TFormatSettings;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( Scale < 0 ) then
    Scale := 1;

  if ( Denoise > 4 ) then
    Denoise := 4;

  if ( PNGCompression > 9 ) then
    PNGCompression := 9;

  if ( JPEG_WebPCompression > 101 ) then
    JPEG_WebPCompression := 101;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '--input "%s" --output "%s" --png-compression %d --image-quality %d --model-dir "%s"', [ FileNameIn, FileNameOut, PNGCompression, JPEG_WebPCompression, Models[ 0 ] ] );

  GetLocaleFormatSettings( 0, LF );
  LF.DecimalSeparator := '.';
  if ( Denoise > 0 ) then
    Params := Params + Format( ' --mode noise-scale --scale-ratio %.2f --noise-level %d', [ Scale, Denoise-1 ], LF )
  else
    Params := Params + Format( ' --mode scale --scale-ratio %.2f', [ Scale ], LF );

  case OFormat of
    ofJPG  : Params := Params + ' --output-format jpg';
    ofPNG  : Params := Params + ' --output-format png';
    ofWebP : Params := Params + ' --output-format webp';
  end;

  if NOT GPU then
    Params := Params + ' --disable-gpu';

  if ForceOpenCL then
    Params := Params + ' --force-OpenCL';

  if TTA then
    Params := Params + ' --tta 1';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Waifu2x Caffe
{
type
  tWaifu2x_Caffe_ProcessMode = ( wcpmCPU, wcpmGPU, wcpmCudnn );

  tWaifu2x_Caffe_Models = (
    wcmCunet,
    wcmAnimeStyleArtRGB,
    wcmAnimeStyleArt,
    wcmPhoto,
    wcmUpConv7_AnimeStyleArtRGB,
    wcmUpConv7_Photo,
    wcmUpResNet10,
    wcmUkBench
  );
}
function Waifu2x_Caffe( FileNameIn, FileNameOut : String;
                        Model : tWaifu2x_Caffe_Models = wcmCunet;
                        ScaleWidth : Cardinal = 0;
                        ScaleHeight : Cardinal = 0;
                        ScaleRatio : Double = 1;
                        CropWidth : Word = 0;
                        CropHeight : Word = 0;
                        CropDivisor : Word = 128;          // Specify the division size. The default value is `128`
                        Denoise : Word = 0;                // Denoise 0=Off, 1=Auto, 2..5
                        Mode : tWaifu2x_Caffe_ProcessMode = wcpmGPU;
                        TTA : Boolean = False;             // Enable Test-Time Augmentation mode
                        ImageQuality : Integer = -1;
                        ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'waifu2x-caffe\waifu2x-caffe-cui.exe';
  Models : Array [ 0..7 ] of String = (
    'models/anime_style_art_rgb',          // 2D illustration (RGB model)
    'models/anime_style_art',              // 2D illustration (Y model)
    'models/photo',                        // Photo/animation (Photo model)
    'models/upconv_7_anime_style_art_rgb', // 2D illustration (UpRGB model)
    'models/upconv_7_photo',               // Photo/Anime (UpPhoto model)
    'models/upresnet10',                   // 2D illustration (UpResNet10 model)
    'models/cunet',                        // 2D illustration (CUnet model)
    'models/ukbench'                       // Old-fashioned photographic model (only the enlarged model is included, noise removal is not possible)
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;  
  LF       : TFormatSettings;
begin
  result := -104;
  if NOT FileExists( FileNameIn ) then
    Exit;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  if ( ScaleRatio < 0 ) then
    ScaleRatio := 1;

  if ( Denoise > 4 ) then
    Denoise := 5;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  Params := Format( '-i "%s" -o "%s" --image-quality %d --model_dir "%s"', [ FileNameIn, FileNameOut, ImageQuality, Models[ Integer( Model ) ] ] );

  GetLocaleFormatSettings( 0, LF );
  LF.DecimalSeparator := '.';
  if ( Denoise = 1 ) then
    Params := Params + ' --mode auto_scale'
  else if ( Denoise > 1 ) then
    Params := Params + Format( ' --mode noise_scale --noise_level %d', [ Denoise-2 ] )
  else
    Params := Params + ' --mode scale';

  if ( ScaleWidth <> 0 ) OR ( ScaleHeight <> 0 ) then
    begin
    if ( ScaleWidth <> 0 ) then
      Params := Params + Format( ' --scale_width %.2f', [ ScaleWidth ], LF );
    if ( ScaleHeight <> 0 ) then
      Params := Params + Format( ' --scale_height %.2f', [ ScaleHeight ], LF );
    end
  else
    Params := Params + Format( ' --scale_ratio %.2f', [ ScaleRatio ], LF );

  if ( CropWidth <> 0 ) then
    Params := Params + Format( ' --crop_w %d', [ CropWidth ] );
  if ( CropHeight <> 0 ) then
    Params := Params + Format( ' --crop_h %d', [ CropHeight ] );

  if ( CropWidth <> 0 ) OR ( CropHeight <> 0 ) then
    Params := Params + Format( ' --crop_size %d', [ CropDivisor ] );

  case Mode of
    wcpmCPU   : Params := Params + ' --process cpu';
    wcpmGPU   : Params := Params + ' --process gpu';
    wcpmCudnn : Params := Params + ' --process cudnn';
  end;

  if TTA then
    Params := Params + ' --tta 1';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Cain NCNN Vulkan
function Cain_NCNN_Vulkan( FileNameIn1, FileNameIn2, FileNameOut : String; Verbose : Boolean = False; ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'cain-ncnn-vulkan\cain-ncnn-vulkan.exe';
  Models : Array [ 0..0 ] of String = (
    'cain'
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;
  i, ID    : Integer;
begin
  result := -106;
  if NOT FileExists( FileNameIn1 ) then
    begin
    if NOT DirectoryExists( FileNameIn1 ) then
      Exit;
      
    if NOT DirectoryExists( FileNameOut ) then
      begin
      result := -105;
      Exit;
      end;
    end
  else
    begin
    if NOT FileExists( FileNameIn2 ) then
      Exit;
      
    result := -104;
    Params := LowerCase( ExtractFileExt( FileNameIn1 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;

    result := -103;
    Params := LowerCase( ExtractFileExt( FileNameIn2 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    
    result := -102;
    Params := LowerCase( ExtractFileExt( FileNameOut ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    end;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  
  if DirectoryExists( FileNameIn1 ) then
    Params := Format( '-i "%s" -o "%s" -m "%s"', [ FileNameIn1, FileNameOut, Models[ 0 ] ] )
  else    
    Params := Format( '-0 "%s" -1 "%s" -o "%s" -m "%s"', [ FileNameIn1, FileNameIn2, FileNameOut, Models[ 0 ] ] );

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Dain NCNN Vulkan
function Dain_NCNN_Vulkan( FileNameIn1,
                           FileNameIn2,
                           FileNameOut : String;
                           FrameCount : Cardinal = 0;
                           TimeStep : Double = 0.5;                       
                           TileSize : Word = 256;
                           Verbose : Boolean = False;
                           ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'Dain-ncnn-vulkan\Dain-ncnn-vulkan.exe';
  Models : Array [ 0..0 ] of String = (
    'best'
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;
  i, ID    : Integer;
begin
  result := -106;
  if NOT FileExists( FileNameIn1 ) then
    begin
    if NOT DirectoryExists( FileNameIn1 ) then
      Exit;
      
    if NOT DirectoryExists( FileNameOut ) then
      begin
      result := -105;
      Exit;
      end;
    end
  else
    begin
    if NOT FileExists( FileNameIn2 ) then
      Exit;
      
    result := -104;
    Params := LowerCase( ExtractFileExt( FileNameIn1 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;

    result := -103;
    Params := LowerCase( ExtractFileExt( FileNameIn2 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    
    result := -102;
    Params := LowerCase( ExtractFileExt( FileNameOut ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    end;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;
    
  if ( TimeStep < 0 ) then
    TimeStep := 0
  else if ( TimeStep > 1 ) then
    TimeStep := 1;

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;
  
  if DirectoryExists( FileNameIn1 ) then
    Params := Format( '-i "%s" -o "%s" -s %.2f -t %d -m "%s"', [ FileNameIn1, FileNameOut, TimeStep, TileSize, Models[ 0 ] ] )
  else
    Params := Format( '-0 "%s" -1 "%s" -o "%s" -s %.2f -t %d -m "%s"', [ FileNameIn1, FileNameIn2, FileNameOut, TimeStep, TileSize, Models[ 0 ] ] );

  if ( FrameCount <> 0 ) then
    Params := Params + Format( ' -n %d', [ FrameCount ] );

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// IfrNet NCNN Vulkan
{
type
  TIfrNet_NCNN_Vulkan_Model = (
    imVimeo90K,
    imS_Vimeo90K,
    imL_Vimeo90K,
    imGoPro,
    imS_GoPro,
    imL_GoPro    
  );
}

function IfrNet_NCNN_Vulkan( FileNameIn1,
                             FileNameIn2,
                             FileNameOut : String;
                             Model : TIfrNet_NCNN_Vulkan_Model = imVimeo90K;
                             TTA : Boolean = False;
                             UltraHD : Boolean = False;
                             FrameCount : Cardinal = 0;
                             TimeStep : Double = 0.5;
                             Verbose : Boolean = False;
                             ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'IfrNet-ncnn-vulkan\IfrNet-ncnn-vulkan.exe';
  Models : Array [ 0..5 ] of String = (
    'IFRNet_Vimeo90K',
    'IFRNet_S_Vimeo90K',
    'IFRNet_L_Vimeo90K',
    'IFRNet_GoPro',
    'IFRNet_S_GoPro',
    'IFRNet_L_GoPro'    
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;
  i, ID    : Integer;
//  LF       : TFormatSettings;
begin
  result := -106;
  if NOT FileExists( FileNameIn1 ) then
    begin
    if NOT DirectoryExists( FileNameIn1 ) then
      Exit;
      
    if NOT DirectoryExists( FileNameOut ) then
      begin
      result := -105;
      Exit;
      end;
    end
  else
    begin
    if NOT FileExists( FileNameIn2 ) then
      Exit;
      
    result := -104;
    Params := LowerCase( ExtractFileExt( FileNameIn1 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;

    result := -103;
    Params := LowerCase( ExtractFileExt( FileNameIn2 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    
    result := -102;
    Params := LowerCase( ExtractFileExt( FileNameOut ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    end;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;
    
  if ( TimeStep < 0 ) then
    TimeStep := 0
  else if ( TimeStep > 1 ) then
    TimeStep := 1;     

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;

//  GetLocaleFormatSettings( 0, LF );
//  LF.DecimalSeparator := '.';
  if DirectoryExists( FileNameIn1 ) then
    Params := Format( '-i "%s" -o "%s" -s %.1f -m "%s"', [ FileNameIn1, FileNameOut, TimeStep, Models[ Integer( Model ) ] ]{, LF} )
  else
    Params := Format( '-0 "%s" -1 "%s" -o "%s" -s %.1f -m "%s"', [ FileNameIn1, FileNameIn2, FileNameOut, TimeStep, Models[ Integer( Model ) ] ]{, LF} );

  if ( FrameCount <> 0 ) then
    Params := Params + Format( ' -n %d', [ FrameCount ] );

  if TTA then
    Params := Params + ' -x';

  if UltraHD then
    Params := Params + ' -u';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// Rife NCNN Vulkan
{
type
  TRife_NCNN_Vulkan_Model = (
    rmRife,
    rmRifeAnime,
    rmRifeHD,
    rmRifeUHD,
    rmRife2,
    rmRife2_3,
    rmRife2_4,
    rmRife3_0,
    rmRife3_1,
    rmRife4
  );
}

function Rife_NCNN_Vulkan( FileNameIn1,
                             FileNameIn2,
                             FileNameOut : String;
                             Model : TRife_NCNN_Vulkan_Model = rmRife2_3;
                             TTA : Boolean = False;
                             UltraHD : Boolean = False;
                             FrameCount : Cardinal = 0;
                             TimeStep : Double = 0.5;
                             Verbose : Boolean = False;
                             ExecuteProc : TExecutePELine = nil ) : Integer;
const
  EXECUTABLE = 'Rife-ncnn-vulkan\Rife-ncnn-vulkan.exe';
  Models : Array [ 0..9 ] of String = (
    'rife',
    'rife-anime',
    'rife-HD',
    'rife-UHD',
    'rife-v2',
    'rife-v2.3',
    'rife-v2.4',
    'rife-v3.0',
    'rife-v3.1',
    'rife-v4'    
  );
var
  FileName : String;
  Params   : String;
  B        : Boolean;
  i, ID    : Integer;
//  LF       : TFormatSettings;
begin
  result := -106;
  if NOT FileExists( FileNameIn1 ) then
    begin
    if NOT DirectoryExists( FileNameIn1 ) then
      Exit;
      
    if NOT DirectoryExists( FileNameOut ) then
      begin
      result := -105;
      Exit;
      end;
    end
  else
    begin
    if NOT FileExists( FileNameIn2 ) then
      Exit;
      
    result := -104;
    Params := LowerCase( ExtractFileExt( FileNameIn1 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;

    result := -103;
    Params := LowerCase( ExtractFileExt( FileNameIn2 ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    
    result := -102;
    Params := LowerCase( ExtractFileExt( FileNameOut ) );
    ID := -1;
    for i := Low( SUPPORTED_FORMATS ) to High( SUPPORTED_FORMATS ) do
      begin
      if ( SUPPORTED_FORMATS[ i ] = Params ) then
        begin
        ID := i;
        Break;
        end;
      end;
    if ( ID < 0 ) then
      Exit;
    end;

  if NOT DirectoryExists( ExtractFileDir( FileNameOut ) ) then
    begin
    if NOT ForceDirectories( ExtractFileDir( FileNameOut ) ) then
      begin
      result := -101;
      Exit;
      end;
    end;

  if FileExists( FileNameOut ) then
    begin
    if NOT DeleteFile( FileNameOut ) then
      begin
      result := -100;
      Exit;
      end;
    end;
    
  if ( TimeStep < 0 ) then
    TimeStep := 0
  else if ( TimeStep > 1 ) then
    TimeStep := 1;     

  FileName := IncludeTrailingPathDelimiter( ExtractFileDir( ParamStr( 0 ) ) ) + EXECUTABLE;

//  GetLocaleFormatSettings( 0, LF );
//  LF.DecimalSeparator := '.';
  if DirectoryExists( FileNameIn1 ) then
    Params := Format( '-i "%s" -o "%s" -s %.1f -m "%s"', [ FileNameIn1, FileNameOut, TimeStep, Models[ Integer( Model ) ] ]{, LF} )
  else
    Params := Format( '-0 "%s" -1 "%s" -o "%s" -s %.1f -m "%s"', [ FileNameIn1, FileNameIn2, FileNameOut, TimeStep, Models[ Integer( Model ) ] ]{, LF} );

  if ( FrameCount <> 0 ) then
    Params := Params + Format( ' -n %d', [ FrameCount ] );

  if TTA then
    Params := Params + ' -x';

  if UltraHD then
    Params := Params + ' -u';

  if Verbose then
    Params := Params + ' -v';

  if Assigned( ExecuteProc ) then
    ExecuteProc( FileName + ' ' + Params, B, False );

  result := ExecutePE( nil, FileName, Params, ''{WorkingDirectory}, ExecuteProc{CaptureLineProc}, ExecutePE_DefaultOptions+[ eoWaitForTerminate ] );
end;

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end.
