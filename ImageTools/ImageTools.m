function varargout = ImageTools(varargin)
% IMAGETOOLS MATLAB code for ImageTools.fig
%      IMAGETOOLS, by itself, creates a new IMAGETOOLS or raises the existing
%      singleton*.
%
%      H = IMAGETOOLS returns the handle to a new IMAGETOOLS or the handle to
%      the existing singleton*.
%
%      IMAGETOOLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGETOOLS.M with the given input arguments.
%
%      IMAGETOOLS('Property','Value',...) creates a new IMAGETOOLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageTools_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageTools_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% editim the above text to modify the response to help ImageTools

% Last Modified by GUIDE v2.5 05-Jun-2017 02:03:43

% Begin initialization code - DO NOT EDITIM
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageTools_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageTools_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDITIM


% --- Executes just before ImageTools is made visible.
function ImageTools_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageTools (see VARARGIN)

% Choose default command line output for ImageTools
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageTools wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageTools_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
image2process = rgb2gray(image);

figure;
subplot(221);
imshow(image2process);
subplot(222);
imhist(image2process);

image2process = histeq(image2process,128);

subplot(223);
imshow(image2process);
subplot(224);
imhist(image2process);

image_processed = image2process;
axes(handles.axes3);
imshow(image_processed);



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
image2process = rgb2gray(image);
gamma = 0.454545;

figure;
subplot(121);
imshow(image2process);
image2process = imadjust(image2process,[],[],gamma);
subplot(122);
imshow(image2process);

image_processed = image2process;
axes(handles.axes3);
imshow(image_processed);




% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
mask = fspecial('average',[3 3]);
image_processed = imfilter(image,mask,'replicate');
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
mask = fspecial('gaussian',[3 3]);
image_processed = imfilter(image,mask,'replicate');
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
str = get(handles.edit1,'String');
theta = str2num(str);
image_processed = Affinetrans_Bilinearity(image,theta,0,0,1,1);
axes(handles.axes3);
imshow(uint8(image_processed(2*size(image,1)+1:3*size(image,1),2*size(image,2)+1:3*size(image,2),:)));




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
str = get(handles.edit2,'String');
theta = str2num(str);
theta = -theta;
image_processed = Affinetrans_Bilinearity(image,theta,0,0,1,1);
axes(handles.axes3);
imshow(uint8(image_processed(2*size(image,1)+1:3*size(image,1),2*size(image,2)+1:3*size(image,2),:)));



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
str = get(handles.edit3,'String');
tx = str2num(str);
image_processed = Affinetrans_Bilinearity(image,0,tx,0,1,1);
axes(handles.axes3);
imshow(uint8(image_processed(2*size(image,1)+1:3*size(image,1),2*size(image,2)+1:3*size(image,2),:)));


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
str = get(handles.edit4,'String');
ty = str2num(str);
image_processed = Affinetrans_Bilinearity(image,0,0,ty,1,1);
axes(handles.axes3);
imshow(uint8(image_processed(2*size(image,1)+1:3*size(image,1),2*size(image,2)+1:3*size(image,2),:)));



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
mask = fspecial('laplacian');
image_processed = imfilter(image,mask,'replicate');
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
mask = fspecial('sobel');
image_processed = imfilter(image,mask,'replicate');
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
index = get(handles.popupmenu4,'Value');
str = get(handles.popupmenu4,'String');
temp = str{index};
image = imread(temp);
axes(handles.axes2);
imshow(image);


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
file = dir('*.bmp');
n = length(file);
name = {file(1).name};
for i = 2:n
    name{i} = file(i).name;
end
set(hObject,'String',name);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
image2process = rgb2gray(image);

figure;
subplot(121);
imshow(image2process);

fa = 40;
fb = 120;
ga = 20;
gb = 160;

a = ga/fa;
b = gb/fb;
b = (gb-ga)/(fb-fa);
c = (255-gb)/(255-fb);

for m = 1:size(image2process,1)
    for n = 1:size(image2process,2)
        if image2process(m,n)<fa
            image_processed(m,n) = a*image2process(m,n);
        else
            if image2process(m,n)>=fa && image2process(m,n)<fb
                image_processed(m,n) = b*(image2process(m,n)-fa)+ga;
            else
                image_processed(m,n) = c*(image2process(m,n)-fb)+gb;
            end
        end
    end
end

subplot(122);
imshow(uint8(image_processed));

axes(handles.axes3);
imshow(uint8(image_processed));


% --------------------------------------------------------------------
function editim_Callback(hObject, eventdata, handles)
% hObject    handle to editim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveim_Callback(hObject, eventdata, handles)
% hObject    handle to saveim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_processed;
imwrite(image_processed,'save.bmg');

% --------------------------------------------------------------------
function copyim_Callback(hObject, eventdata, handles)
% hObject    handle to copyim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
print -dmeta;


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
str1 = get(handles.edit6,'String');
str2 = get(handles.edit7,'String');
sx = str2num(str1)/100;
sy = str2num(str2)/100;
image_processed = Affinetrans_Bilinearity(image,0,0,0,sx,sy);
axes(handles.axes3);
imshow(uint8(image_processed(2*size(image,1)+1:3*size(image,1),2*size(image,2)+1:3*size(image,2),:)));



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');

% Hint: place code in OpeningFcn to populate axes2

function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'xTick',[]);
set(hObject,'ytick',[]);
set(hObject,'box','on');

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function pushbutton19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
image2process = rgb2gray(image);
image_f = fft2(image2process);
image_f = fftshift(image_f);
M = size(image_f,1);
N = size(image_f,2);
n = 0.5;
d0 = 50;
xzero = fix(M/2);
yzero = fix(N/2);
for i = 1:M
    for j = 1:N
        d = sqrt((i-xzero)^2+(j-yzero)^2);
        H = 1/(1+(d/d0)^(2*n));
        image_f(i,j) = H * image_f(i,j);
    end
end
image_f = ifftshift(image_f);
image_processed = uint8(ifft2(image_f));
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global image_processed;
image2process = rgb2gray(image);
image_f = fft2(image2process);
image_f = fftshift(image_f);
M = size(image_f,1);
N = size(image_f,2);
n = 0.5;
d0 = 50;
xzero = fix(M/2);
yzero = fix(N/2);
for i = 1:M
    for j = 1:N
        d = sqrt((i-xzero)^2+(j-yzero)^2);
        H = 1/(1+(d0/d)^(2*n));
        image_f(i,j) = H * image_f(i,j);
    end
end
image_f = ifftshift(image_f);
image_processed = uint8(ifft2(image_f));
axes(handles.axes3);
imshow(image_processed);


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = get(handles.edit8,'String');
str2 = get(handles.edit9,'String');
str3 = get(handles.edit10,'String');
r = str2num(str1);
g = str2num(str2);
b = str2num(str3);
image2process = cat(3, r, g, b);
image2process_hsi = rgb2hsi(image2process);
set(handles.edit11,'string',num2str(image2process_hsi(1)-eps));
set(handles.edit12,'string',num2str(image2process_hsi(2)));
set(handles.edit13,'string',num2str(image2process_hsi(3)));




% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = get(handles.edit8,'String');
str2 = get(handles.edit9,'String');
str3 = get(handles.edit10,'String');
h = str2num(str1);
s = str2num(str2);
i = str2num(str3);
image2process = cat(3, h, s, i);
image2process_rgb = hsi2rgb(image2process);
set(handles.edit11,'string',num2str(round(image2process_rgb(1)*256-1)));
set(handles.edit12,'string',num2str(round(image2process_rgb(2)*256-1)));
set(handles.edit13,'string',num2str(round(image2process_rgb(3)*256-1)));


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str1 = get(handles.edit8,'String');
str2 = get(handles.edit9,'String');
str3 = get(handles.edit10,'String');
r = str2num(str1);
g = str2num(str2);
b = str2num(str3);
set(handles.edit11,'string',num2str(255-r));
set(handles.edit12,'string',num2str(255-g));
set(handles.edit13,'string',num2str(255-b));



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: editim controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


% --------------------------------------------------------------------
function openim_Callback(hObject, eventdata, handles)
% hObject    handle to openim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'Ñ¡ÔñÍ¼Æ¬');
if isequal(filename,0)
    disp('Users Selected Canceled');
else
str=[pathname filename];
image = imread(str);
axes(handles.axes2);
imshow(image);
end;
