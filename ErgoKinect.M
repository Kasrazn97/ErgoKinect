function varargout = test4(varargin)
% TEST4 MATLAB code for test4.fig
%      TEST4, by itself, creates a new TEST4 or raises the existing
%      singleton*.
%
%      H = TEST4 returns the handle to a new TEST4 or the handle to
%      the existing singleton*.
%
%      TEST4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST4.M with the given input arguments.
%
%      TEST4('Property','Value',...) creates a new TEST4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test4

% Last Modified by GUIDE v2.5 23-May-2018 11:27:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test4_OpeningFcn, ...
                   'gui_OutputFcn',  @test4_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before test4 is made visible.
function test4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test4 (see VARARGIN)

% Choose default command line output for test4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global var_gui
var_gui.StateStart=false;
% UIWAIT makes test4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global var_gui

if ~var_gui.StateStart
    var_gui.StateStart=true;
    %      set(handles.pushbutton1,'Enable','off')
    set(handles.start,'string','STOP')
    set(handles.start,'backgroundColor',[1 0 0] )
    imaqreset;
    var_gui.depthVid=videoinput('kinect',2);
    triggerconfig(var_gui.depthVid,'manual');
    var_gui.depthVid.FramesPerTrigger=1;
    var_gui.depthVid.TriggerRepeat=inf;
    depthSource = getselectedsource(var_gui.depthVid);
    depthSource.EnableBodyTracking = 'on';
    viewer=vision.DeployableVideoPlayer();
    start(var_gui.depthVid);
    SkeletonConnectionMap=[[21 3];[3 4];[21 5];[5 6];[6 7];[7 8];[8 23];[8 22];[21 9];[9 10];...
        [10 11];[11 12];[12 24];[12 25];[21 2];[2 1];[1 17];[1 13];[17 18];[18 19];[19 20];[13 14];[14 15];[15 16]];
    tic
    global position;
    kasra=0;
    lower=0;
    upper=2;
    while (toc<30)
        trigger(var_gui.depthVid);
        try
            [depthmap,~,lastframeMetadata1]=getdata(var_gui.depthVid);
        catch
        end
        for jj=1:1
            
            lastframeMetadata=lastframeMetadata1(jj);
            anyBodiesTracked = any(lastframeMetadata.IsBodyTracked ~= 0);
            trackedBodies = find(lastframeMetadata.IsBodyTracked);
            % Find number of Skeletons tracked.
            nBodies = length(trackedBodies);
            % Get the joint indices of the tracked bodies with respect to the color
            % image.
            %         colorJointIndices = lastframeMetadata.ColorJointIndices(:, :, trackedBodies);
            DepthJointIndices=lastframeMetadata.DepthJointIndices(:, :, trackedBodies);
            % Extract the 90th color frame.
            % lastColorImage = colorImg(:, :, :, lastFrame);
            % View RGB image with skeletal overlay.
            % Marker colors for up to 6 bodies.
            colors = ['r';'g';'b';'c';'y';'m'];
            handles.axes1;
            imshow(depthmap(:,:,1,jj),[0 4096]);
            drawnow;
            
            if anyBodiesTracked
                
                
                for i=1:nBodies
                    
                    %         imshow(depthmap(:,:,1,end),[0 4096]);
                    hold on
                    %                 kat=depthmap;
                    %                 kat2=lastframeMetadata;
                    %        plot(lastframeMetadata.ColorJointIndices(:,1,trackedBodies(i)),lastframeMetadata.ColorJointIndices(:,2,trackedBodies(i)),'*r');
                    % plot(lastframeMetadata.DepthJointIndices(:,1,trackedBodies(i)),lastframeMetadata.DepthJointIndices(:,2,trackedBodies(i)),'*r');
                    
                end
                
                
                for i = 1:24
                    hold on;
                    for body = 1:nBodies
                        %             X1 = [colorJointIndices(SkeletonConnectionMap(i,1),1,body) colorJointIndices(SkeletonConnectionMap(i,2),1,body)];
                        %             Y1 = [colorJointIndices(SkeletonConnectionMap(i,2),2,body) colorJointIndices(SkeletonConnectionMap(i,1),2,body)];
                        %             X1 = [DepthJointIndices(SkeletonConnectionMap(i,1),1,body) DepthJointIndices(SkeletonConnectionMap(i,2),1,body)];
                        %             Y1 = [DepthJointIndices(SkeletonConnectionMap(i,2),2,body) DepthJointIndices(SkeletonConnectionMap(i,1),2,body)];
                        
                        line(handles.axes1,DepthJointIndices([SkeletonConnectionMap(i,1) SkeletonConnectionMap(i,2)],1),DepthJointIndices([SkeletonConnectionMap(i,1) SkeletonConnectionMap(i,2)],2), 'LineWidth', 1.5, 'LineStyle', '-', 'Marker', '+', 'Color', colors(body));
 k=[];
                        %% matrix
                        
                        %% timing
%                         lower=0;
%                         upper=12;
                        
%                         while toc<=40
%                              if(toc>=lower && toc<upper )
% for coun=0:1:10
%     if(kasra<10)
                        %% Knee
                        k(3,1)=DepthJointIndices(18,1)-DepthJointIndices(17,1);
                        k(3,2)=DepthJointIndices(18,2)-DepthJointIndices(17,2);
                        k(4,1)=DepthJointIndices(18,1)-DepthJointIndices(19,1);
                        k(4,2)=DepthJointIndices(18,2)-DepthJointIndices(19,2);
                        thetaknee=rad2deg(acos((k(3,:)*k(4,:)')/(norm(k(3,:))*norm(k(4,:)))));
                        set(handles.Knee1,'str',num2str(thetaknee));
                        %% Ankle
%                         k(1,1)=DepthJointIndices(19,1)-DepthJointIndices(18,1);
%                         k(1,2)=DepthJointIndices(19,2)-DepthJointIndices(18,2);
%                         k(2,1)=DepthJointIndices(19,1)-DepthJointIndices(20,1);
%                         k(2,2)=DepthJointIndices(19,2)-DepthJointIndices(20,2);
%                         thetaankle=rad2deg(acos((k(1,:)*k(2,:)')/(norm(k(1,:))*norm(k(2,:)))));
%                         set(handles.Ankle1,'str',num2str(thetaankle));
                        %% Upper Foot
%                         k(5,1)=DepthJointIndices(17,1)-DepthJointIndices(1,1);
%                         k(5,2)=DepthJointIndices(17,2)-DepthJointIndices(1,2);
%                         k(6,1)=DepthJointIndices(17,1)-DepthJointIndices(18,1);
%                         k(6,2)=DepthJointIndices(17,2)-DepthJointIndices(18,2);
%                         thetaupperfoot=rad2deg(atan(k(6,2)/k(6,1)));
%                         set(handles.RUfoot,'str',num2str(thetaupperfoot));
                        

                        %% Waist
                        k(7,1)=DepthJointIndices(21,1)-DepthJointIndices(3,1);
                        k(7,2)=DepthJointIndices(21,2)-DepthJointIndices(3,2);
                        k(8,1)=DepthJointIndices(21,1)-DepthJointIndices(1,1);
                        k(8,2)=DepthJointIndices(21,2)-DepthJointIndices(1,2);
                        thetawaist=rad2deg(atan(k(8,2)/k(8,1)));
                        set(handles.Waist1,'str',num2str(thetawaist));
                        %% Back
                        k(9,1)=DepthJointIndices(21,1)-DepthJointIndices(3,1);
                        k(9,2)=DepthJointIndices(21,2)-DepthJointIndices(3,2);
                        k(10,1)=DepthJointIndices(21,1)-DepthJointIndices(2,1);
                        k(10,2)=DepthJointIndices(21,2)-DepthJointIndices(2,2);
                        thetaback=rad2deg(acos((k(9,:)*k(10,:)')/(norm(k(9,:))*norm(k(10,:)))));
                        set(handles.Back1,'str',num2str(thetaback));
                        %% Neck
                        k(11,1)=DepthJointIndices(3,1)-DepthJointIndices(4,1);
                        k(11,2)=DepthJointIndices(3,2)-DepthJointIndices(4,2);
                        k(12,1)=DepthJointIndices(3,1)-DepthJointIndices(21,1);
                        k(12,2)=DepthJointIndices(3,2)-DepthJointIndices(21,2);
                        thetaneck=rad2deg(acos((k(11,:)*k(12,:)')/(norm(k(11,:))*norm(k(12,:)))));
                        set(handles.Neck1,'str',num2str(thetaneck));
                        %% Wrist
                        k(13,1)=DepthJointIndices(12,1)-DepthJointIndices(11,1);
                        k(13,2)=DepthJointIndices(12,2)-DepthJointIndices(11,2);
                        k(14,1)=DepthJointIndices(12,1)-DepthJointIndices(24,1);
                        k(14,2)=DepthJointIndices(12,2)-DepthJointIndices(24,2);
                        thetawrist=rad2deg(acos((k(13,:)*k(14,:)')/(norm(k(13,:))*norm(k(14,:)))));
                        set(handles.Wrist1,'str',num2str(thetawrist));
                        %% Elbow
                        k(15,1)=DepthJointIndices(10,1)-DepthJointIndices(9,1);
                        k(15,2)=DepthJointIndices(10,2)-DepthJointIndices(9,2);
                        k(16,1)=DepthJointIndices(10,1)-DepthJointIndices(11,1);
                        k(16,2)=DepthJointIndices(10,2)-DepthJointIndices(11,2);
                        thetaelbow=rad2deg(acos((k(15,:)*k(16,:)')/(norm(k(15,:))*norm(k(16,:)))));
                        set(handles.Relbow1,'str',num2str(thetaelbow));
                        %% Arm
                        k(17,1)=DepthJointIndices(9,1)-DepthJointIndices(10,1);
                        k(17,2)=DepthJointIndices(9,2)-DepthJointIndices(10,2);
                        thetaarm=rad2deg(atan(k(17,2)/k(17,1)));
                        set(handles.Rarm1,'str',num2str(thetaarm));
                        %% matrix filling
                        kasra=kasra+1;
                        if toc >10
                              position=[position;thetaknee>90 && thetaknee<115,thetawaist<-70 || thetawaist>70,thetaback>165 && thetaback<180,thetaneck>160 && thetaneck<180,thetawrist>170 && thetawrist<180,thetaelbow>85 && thetaelbow<130,thetaarm<-60 || thetaarm>80];
                        end
                       
                        %% time update
                        lower=lower+2;
                        upper=upper+2;
                      
% end
                             
%                         end
                    end
                    
                    
                end
                hold off;
            end
            drawnow
        end  
    end
    
    display(position);
    display(kasra);
    
    
    
    
    
    
else
    pause(2)
    var_gui.StateStart=false;
    
    stop(var_gui.depthVid);
    cla(handles.axes1,'reset');
    drawnow;
    set(handles.start,'string','START')
    set(handles.start,'backgroundColor',[.94 .94 .94] )
    
end



function Knee1_Callback(hObject, eventdata, handles)
% hObject    handle to Knee1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Knee1 as text
%        str2double(get(hObject,'String')) returns contents of Knee1 as a double


% --- Executes during object creation, after setting all properties.
function Knee1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Knee1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ankle1_Callback(hObject, eventdata, handles)
% hObject    handle to Ankle1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ankle1 as text
%        str2double(get(hObject,'String')) returns contents of Ankle1 as a double


% --- Executes during object creation, after setting all properties.
function Ankle1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ankle1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RUfoot1_Callback(hObject, eventdata, handles)
% hObject    handle to RUfoot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RUfoot1 as text
%        str2double(get(hObject,'String')) returns contents of RUfoot1 as a double


% --- Executes during object creation, after setting all properties.
function RUfoot1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RUfoot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Waist1_Callback(hObject, eventdata, handles)
% hObject    handle to Waist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Waist1 as text
%        str2double(get(hObject,'String')) returns contents of Waist1 as a double


% --- Executes during object creation, after setting all properties.
function Waist1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Waist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Back1_Callback(hObject, eventdata, handles)
% hObject    handle to Back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Back1 as text
%        str2double(get(hObject,'String')) returns contents of Back1 as a double


% --- Executes during object creation, after setting all properties.
function Back1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Neck1_Callback(hObject, eventdata, handles)
% hObject    handle to Neck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Neck1 as text
%        str2double(get(hObject,'String')) returns contents of Neck1 as a double


% --- Executes during object creation, after setting all properties.
function Neck1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Neck1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Wrist1_Callback(hObject, eventdata, handles)
% hObject    handle to Wrist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Wrist1 as text
%        str2double(get(hObject,'String')) returns contents of Wrist1 as a double


% --- Executes during object creation, after setting all properties.
function Wrist1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Wrist1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Relbow1_Callback(hObject, eventdata, handles)
% hObject    handle to Relbow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Relbow1 as text
%        str2double(get(hObject,'String')) returns contents of Relbow1 as a double


% --- Executes during object creation, after setting all properties.
function Relbow1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Relbow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Rarm1_Callback(hObject, eventdata, handles)
% hObject    handle to Rarm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Rarm1 as text
%        str2double(get(hObject,'String')) returns contents of Rarm1 as a double


% --- Executes during object creation, after setting all properties.
function Rarm1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rarm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
