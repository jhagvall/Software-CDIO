classdef DataAcquisitionSDFv_2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        StartCamera             matlab.ui.control.Button
        CaptureImageButton      matlab.ui.control.Button
        StartVideoButton        matlab.ui.control.Button
        SaveButton              matlab.ui.control.Button
        FilenameEditFieldLabel  matlab.ui.control.Label
        Filename                matlab.ui.control.EditField
        DirectoryButton         matlab.ui.control.Button
        UIAxes                  matlab.ui.control.UIAxes
    end


    properties (Access = private)
        vid =  videoinput('winvideo', 1);
        is = 0; % incremental value for snapshot - used to rename picture file
        iv = 0; % incremental value for video - used to rename video file
        directory = pwd;
        fileNameVerif = '';
        im;
        vidRes;
    end


    methods (Access = private)

        % Button pushed function: StartCamera
        function StartCameraButtonPushed(app, event)
% Create a figure window. 

fig = figure('Toolbar','none',...
       'Menubar', 'none',...
       'NumberTitle','Off',...
       'Name','My Preview Window');
LSV = axes(fig);
% Create the image object in which you want to display 
% the video preview data. Make the size of the image
% object match the dimensions of the video frames.

app.vidRes = app.vid.VideoResolution
nBands =app.vid.NumberOfBands;
hImage = image(LSV, zeros(app.vidRes(2), app.vidRes(1), nBands));

% Display the video data.
app.im = getsnapshot(app.vid);
preview(app.vid, hImage); 
        end

        % Button pushed function: CaptureImageButton
        function CaptureImageButtonPushed(app, event)
        % Remove title, axis labels, and tick labels
% title(app.UIAxes, []);
xlabel(app.UIAxes, []);
ylabel(app.UIAxes, []);
app.UIAxes.XAxis.TickLabels = {};
app.UIAxes.YAxis.TickLabels = {};
            
set(app.vid,'ReturnedColorSpace','rgb');
app.im =  getsnapshot(app.vid);
 
% % Display image and stretch to fill axes
imshow(app.im, 'Parent', app.UIAxes)

        end

        % Button pushed function: StartVideoButton
        function StartVideoButtonPushed(app, event)
%            Video = videoinput(app.vid2,deviceID,format) 
    
            vobj = app.vid;
            fileName = app.Filename.Value;
            
            if strcmp(app.StartVideoButton.Text,'Start Video') == 1
                % Change button Name
                app.StartVideoButton.Text = 'Stop Video';
                
                %initialize video object
                vobj.TimeOut = Inf;
                vobj.FrameGrabInterval = 1;
                vobj.LoggingMode = 'disk&memory';
                vobj.FramesPerTrigger = 1;
                vobj.TriggerRepeat = Inf;
%                 vobj.TriggerFrameDelay = 5; % to skip the log frames
                
                % set the framerate of the video at the highes available
%                 src = getselectedsource(vobj);
%                 frameRates = set(src, 'FrameRate')
%                 src.FrameRate = frameRates{1};
%                 actualRate = str2num( frameRates{1} );
                
                % generate file name
                if strcmp(app.fileNameVerif,fileName) == 1
                    dir = strcat(app.directory,'\', fileName,'_', num2str(app.is));
                    app.is = app.is+1;
                else
                    app.is = 0;
                    dir = strcat(app.directory,'\', fileName,'_', num2str(app.is));
                    app.is = app.is+1;
                end
                
                 % generate video file
                v = VideoWriter([dir, '.avi']);
                v.Quality = 50;
                v.FrameRate = 25;  % lower the value -> slow motion. Can be useful if the movement is to fast
                vobj.DiskLogger = v;
                
                % Select the source to use for acquisition.
                vobj.SelectedSourceName = 'input1';
                tic
                % Start acquisition
                start(vobj)
                

            else % the user wants to end video recording
                % generate file name
                if strcmp(app.fileNameVerif,fileName) == 1
                    dir = strcat(app.directory,'\', fileName,'_', num2str(app.is));
                    app.is = app.is+1;
                else
                    app.is = 0;
                    dir = strcat(app.directory,'\', fileName,'_', num2str(app.is));
                    app.is = app.is+1;
                end
               
               % Change button Name
               app.StartVideoButton.Text = 'Start Video';
               
               % stop video recording
               stop(vobj)               
               % delete(vobj);
            end
           
        end

        % Button pushed function: DirectoryButton
        function DirectoryButtonPushed(app, event)
            app.directory = uigetdir;          
        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, event)
            % generate directory and update incremental value
            fileName = app.Filename.Value;
            if strcmp(app.fileNameVerif,fileName) == 1
                dir = strcat(app.directory,'\', fileName,'_', num2str(app.is),'.png');
                app.is = app.is+1
            else
                app.is = 0;
                dir = strcat(app.directory,'\', fileName,'_', num2str(app.is),'.png');
                app.is = app.is+1
            end           
            imwrite(app.im, dir, 'png');            
            app.fileNameVerif = fileName;
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            fileName = app.Filename.Value;
            dir = strcat(app.directory,'\', fileName,'_', 'autosave_close','.png');
            if app.is == 0
            closepreview(app.vid);
            close all;
            delete(app)
            else
            imwrite(app.im, dir, 'png');
            closepreview(app.vid);
            close all;
            delete(app)
            end
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 349];
            app.UIFigure.Name = 'UI Figure';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create StartCamera
            app.StartCamera = uibutton(app.UIFigure, 'push');
            app.StartCamera.ButtonPushedFcn = createCallbackFcn(app, @StartCameraButtonPushed, true);
            app.StartCamera.FontSize = 20;
            app.StartCamera.Position = [26 247 134 43];
            app.StartCamera.Text = 'Start Camera';

            % Create CaptureImageButton
            app.CaptureImageButton = uibutton(app.UIFigure, 'push');
            app.CaptureImageButton.ButtonPushedFcn = createCallbackFcn(app, @CaptureImageButtonPushed, true);
            app.CaptureImageButton.FontSize = 20;
            app.CaptureImageButton.Position = [19 94 148 33];
            app.CaptureImageButton.Text = 'Capture Image';

            % Create StartVideoButton
            app.StartVideoButton = uibutton(app.UIFigure, 'push');
            app.StartVideoButton.ButtonPushedFcn = createCallbackFcn(app, @StartVideoButtonPushed, true);
            app.StartVideoButton.FontSize = 20;
            app.StartVideoButton.Position = [19 27 114 33];
            app.StartVideoButton.Text = 'Start Video';

            % Create SaveButton
            app.SaveButton = uibutton(app.UIFigure, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.FontSize = 20;
            app.SaveButton.Position = [177 94 83 33];
            app.SaveButton.Text = 'Save ';

            % Create FilenameEditFieldLabel
            app.FilenameEditFieldLabel = uilabel(app.UIFigure);
            app.FilenameEditFieldLabel.HorizontalAlignment = 'center';
            app.FilenameEditFieldLabel.VerticalAlignment = 'center';
            app.FilenameEditFieldLabel.FontSize = 20;
            app.FilenameEditFieldLabel.Position = [26 153 93 26];
            app.FilenameEditFieldLabel.Text = 'File name';

            % Create Filename
            app.Filename = uieditfield(app.UIFigure, 'text');
            app.Filename.FontSize = 20;
            app.Filename.Position = [125 152 135 28];

            % Create DirectoryButton
            app.DirectoryButton = uibutton(app.UIFigure, 'push');
            app.DirectoryButton.ButtonPushedFcn = createCallbackFcn(app, @DirectoryButtonPushed, true);
            app.DirectoryButton.FontSize = 20;
            app.DirectoryButton.Position = [26 195 100 33];
            app.DirectoryButton.Text = 'Directory';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            app.UIAxes.Position = [276 13 365 337];
        end
    end

    methods (Access = public)

        % Construct app
        function app = DataAcquisitionSDFv_2

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end