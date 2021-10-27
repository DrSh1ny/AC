classdef gui < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        StartButton                    matlab.ui.control.Button
        ClassifierLayerNumberDropDown  matlab.ui.control.DropDown
        ClassifierLayerNumberDropDownLabel  matlab.ui.control.Label
        ChooseanArchitectureLabel      matlab.ui.control.Label
        FilterDropDown                 matlab.ui.control.DropDown
        FilterDropDownLabel            matlab.ui.control.Label
        ClassifierActivationFunctionDropDown_4  matlab.ui.control.DropDown
        ClassifierActivationFunctionDropDown_4Label  matlab.ui.control.Label
    end

    
    methods (Access = private)
        
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
        function StartFcn(app, event)
            runNeuralNetwork(app.FilterDropDown.Value, app.ClassifierLayerNumberDropDown.Value, app.ClassifierActivationFunctionDropDown_4.Value);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.0902 0.2314 0.3216];
            app.UIFigure.Position = [100 100 438 261];
            app.UIFigure.Name = 'MATLAB App';

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartFcn, true);
            app.StartButton.Position = [283 29 100 22];
            app.StartButton.Text = 'Start';

            % Create ClassifierLayerNumberDropDown
            app.ClassifierLayerNumberDropDown = uidropdown(app.UIFigure);
            app.ClassifierLayerNumberDropDown.Items = {'1', '2'};
            app.ClassifierLayerNumberDropDown.BackgroundColor = [0.902 0.902 0.902];
            app.ClassifierLayerNumberDropDown.Position = [227 147 152 22];
            app.ClassifierLayerNumberDropDown.Value = '1';

            % Create ClassifierLayerNumberDropDownLabel
            app.ClassifierLayerNumberDropDownLabel = uilabel(app.UIFigure);
            app.ClassifierLayerNumberDropDownLabel.BackgroundColor = [0.0902 0.2314 0.3216];
            app.ClassifierLayerNumberDropDownLabel.HorizontalAlignment = 'right';
            app.ClassifierLayerNumberDropDownLabel.FontColor = [0.902 0.902 0.902];
            app.ClassifierLayerNumberDropDownLabel.Position = [53 147 159 22];
            app.ClassifierLayerNumberDropDownLabel.Text = 'Classifier Layer Number';

            % Create ChooseanArchitectureLabel
            app.ChooseanArchitectureLabel = uilabel(app.UIFigure);
            app.ChooseanArchitectureLabel.FontSize = 18;
            app.ChooseanArchitectureLabel.FontColor = [0.902 0.902 0.902];
            app.ChooseanArchitectureLabel.Position = [123 224 193 22];
            app.ChooseanArchitectureLabel.Text = 'Choose an Architecture';

            % Create FilterDropDown
            app.FilterDropDown = uidropdown(app.UIFigure);
            app.FilterDropDown.Items = {'None', 'Associative Memory', 'Binary Perceptron'};
            app.FilterDropDown.BackgroundColor = [0.902 0.902 0.902];
            app.FilterDropDown.Position = [227 185 152 22];
            app.FilterDropDown.Value = 'None';

            % Create FilterDropDownLabel
            app.FilterDropDownLabel = uilabel(app.UIFigure);
            app.FilterDropDownLabel.BackgroundColor = [0.0902 0.2314 0.3216];
            app.FilterDropDownLabel.HorizontalAlignment = 'right';
            app.FilterDropDownLabel.FontColor = [0.902 0.902 0.902];
            app.FilterDropDownLabel.Position = [53 185 159 22];
            app.FilterDropDownLabel.Text = 'Filter';

            % Create ClassifierActivationFunctionDropDown_4
            app.ClassifierActivationFunctionDropDown_4 = uidropdown(app.UIFigure);
            app.ClassifierActivationFunctionDropDown_4.Items = {'Linear', 'Hard Limit', 'Sigmoidal'};
            app.ClassifierActivationFunctionDropDown_4.BackgroundColor = [0.902 0.902 0.902];
            app.ClassifierActivationFunctionDropDown_4.Position = [227 98 152 22];
            app.ClassifierActivationFunctionDropDown_4.Value = 'Linear';

            % Create ClassifierActivationFunctionDropDown_4Label
            app.ClassifierActivationFunctionDropDown_4Label = uilabel(app.UIFigure);
            app.ClassifierActivationFunctionDropDown_4Label.BackgroundColor = [0.0902 0.2314 0.3216];
            app.ClassifierActivationFunctionDropDown_4Label.HorizontalAlignment = 'right';
            app.ClassifierActivationFunctionDropDown_4Label.FontColor = [0.902 0.902 0.902];
            app.ClassifierActivationFunctionDropDown_4Label.Position = [53 98 159 22];
            app.ClassifierActivationFunctionDropDown_4Label.Text = 'Classifier Activation Function';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = gui

            % Create UIFigure and components
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