classdef gui_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        ChooseanArchitectureLabel   matlab.ui.control.Label
        ClassifierActivationFunctionDropDownLabel  matlab.ui.control.Label
        ClassifierActivationFunctionDropDown  matlab.ui.control.DropDown
        NeuralNetworkDropDownLabel  matlab.ui.control.Label
        NeuralNetworkDropDown       matlab.ui.control.DropDown
        StartButton                 matlab.ui.control.Button
    end

    
    methods (Access = private)
        
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
        function StartFcn(app, event)
            runNeuralNetwork(app.NeuralNetworkDropDown.Value, app.ClassifierActivationFunctionDropDown.Value);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.0902 0.2314 0.3216];
            app.UIFigure.Position = [100 100 438 190];
            app.UIFigure.Name = 'MATLAB App';

            % Create StartButton
            app.StartButton = uibutton(app.UIFigure, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartFcn, true);
            app.StartButton.Position = [282 31 100 22];
            app.StartButton.Text = 'Start';

            % Create NeuralNetworkDropDown
            app.NeuralNetworkDropDown = uidropdown(app.UIFigure);
            app.NeuralNetworkDropDown.Items = {'Classifier(1 Layer)', 'Classifier(2 Layer)', 'Filter + Classifier(1 Layer)'};
            app.NeuralNetworkDropDown.BackgroundColor = [0.902 0.902 0.902];
            app.NeuralNetworkDropDown.Position = [229 116 153 22];
            app.NeuralNetworkDropDown.Value = 'Classifier(1 Layer)';

            % Create NeuralNetworkDropDownLabel
            app.NeuralNetworkDropDownLabel = uilabel(app.UIFigure);
            app.NeuralNetworkDropDownLabel.BackgroundColor = [0.0902 0.2314 0.3216];
            app.NeuralNetworkDropDownLabel.FontColor = [0.902 0.902 0.902];
            app.NeuralNetworkDropDownLabel.Position = [56 116 159 22];
            app.NeuralNetworkDropDownLabel.Text = 'Neural Network';

            % Create ClassifierActivationFunctionDropDown
            app.ClassifierActivationFunctionDropDown = uidropdown(app.UIFigure);
            app.ClassifierActivationFunctionDropDown.Items = {'Linear', 'HardLim', 'Sigmoidal'};
            app.ClassifierActivationFunctionDropDown.BackgroundColor = [0.902 0.902 0.902];
            app.ClassifierActivationFunctionDropDown.Position = [230 75 152 22];
            app.ClassifierActivationFunctionDropDown.Value = 'Linear';

            % Create ClassifierActivationFunctionDropDownLabel
            app.ClassifierActivationFunctionDropDownLabel = uilabel(app.UIFigure);
            app.ClassifierActivationFunctionDropDownLabel.BackgroundColor = [0.0902 0.2314 0.3216];
            app.ClassifierActivationFunctionDropDownLabel.HorizontalAlignment = 'right';
            app.ClassifierActivationFunctionDropDownLabel.FontColor = [0.902 0.902 0.902];
            app.ClassifierActivationFunctionDropDownLabel.Position = [56 75 159 22];
            app.ClassifierActivationFunctionDropDownLabel.Text = 'Classifier Activation Function';

            % Create ChooseanArchitectureLabel
            app.ChooseanArchitectureLabel = uilabel(app.UIFigure);
            app.ChooseanArchitectureLabel.FontSize = 18;
            app.ChooseanArchitectureLabel.FontColor = [0.902 0.902 0.902];
            app.ChooseanArchitectureLabel.Position = [123 153 193 22];
            app.ChooseanArchitectureLabel.Text = 'Choose an Architecture';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = gui_exported

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