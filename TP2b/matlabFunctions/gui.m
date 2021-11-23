classdef gui < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        TrainTestButton             matlab.ui.control.Button
        DetectionModeCheckBox       matlab.ui.control.CheckBox
        PatientDropDown             matlab.ui.control.DropDown
        PatientDropDownLabel        matlab.ui.control.Label
        SpecificityPanel            matlab.ui.container.Panel
        Label2                      matlab.ui.control.Label
        SensibilityPanel            matlab.ui.container.Panel
        Label1                      matlab.ui.control.Label
        TestButton                  matlab.ui.control.Button
        NeuralNetworkDropDown       matlab.ui.control.DropDown
        NeuralNetworkDropDownLabel  matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: TestButton
        function TestButtonPushed(app, event)
            
            [sensitivity, specificity] = runNN(app.PatientDropDown.Value, app.NeuralNetworkDropDown.Value, app.DetectionModeCheckBox.Value, 0);
            app.Label1.Text = string(sensitivity);
            app.Label2.Text = string(specificity);
        end

        % Button pushed function: TrainTestButton
        function TrainTestButtonPushed(app, event)
            [sensitivity, specificity] = runNN(app.PatientDropDown.Value, app.NeuralNetworkDropDown.Value, app.DetectionModeCheckBox.Value, 1);
            app.Label1.Text = string(sensitivity);
            app.Label2.Text = string(specificity);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.302 0.651 0.8314];
            app.UIFigure.Position = [100 100 328 235];
            app.UIFigure.Name = 'Neural Network 2b';

            % Create NeuralNetworkDropDownLabel
            app.NeuralNetworkDropDownLabel = uilabel(app.UIFigure);
            app.NeuralNetworkDropDownLabel.BackgroundColor = [0.302 0.651 0.8314];
            app.NeuralNetworkDropDownLabel.Position = [30 157 88 22];
            app.NeuralNetworkDropDownLabel.Text = 'Neural Network';

            % Create NeuralNetworkDropDown
            app.NeuralNetworkDropDown = uidropdown(app.UIFigure);
            app.NeuralNetworkDropDown.Items = {'FeedForward', 'DynamicNN', 'CNN', 'LSTM'};
            app.NeuralNetworkDropDown.BackgroundColor = [0.3294 0.7412 0.9412];
            app.NeuralNetworkDropDown.Position = [141 157 158 22];
            app.NeuralNetworkDropDown.Value = 'FeedForward';

            % Create TestButton
            app.TestButton = uibutton(app.UIFigure, 'push');
            app.TestButton.ButtonPushedFcn = createCallbackFcn(app, @TestButtonPushed, true);
            app.TestButton.BackgroundColor = [0.3294 0.7412 0.9412];
            app.TestButton.FontColor = [1 1 1];
            app.TestButton.Position = [208 95 70 22];
            app.TestButton.Text = 'Test';

            % Create SensibilityPanel
            app.SensibilityPanel = uipanel(app.UIFigure);
            app.SensibilityPanel.BorderType = 'none';
            app.SensibilityPanel.Title = 'Sensibility';
            app.SensibilityPanel.BackgroundColor = [0.302 0.651 0.8314];
            app.SensibilityPanel.Position = [42 24 100 43];

            % Create Label1
            app.Label1 = uilabel(app.SensibilityPanel);
            app.Label1.BackgroundColor = [0.3294 0.7412 0.9412];
            app.Label1.Position = [1 2 100 22];
            app.Label1.Text = '0.0';

            % Create SpecificityPanel
            app.SpecificityPanel = uipanel(app.UIFigure);
            app.SpecificityPanel.BorderType = 'none';
            app.SpecificityPanel.Title = 'Specificity';
            app.SpecificityPanel.BackgroundColor = [0.302 0.651 0.8314];
            app.SpecificityPanel.Position = [187 25 112 43];

            % Create Label2
            app.Label2 = uilabel(app.SpecificityPanel);
            app.Label2.BackgroundColor = [0.3294 0.7412 0.9412];
            app.Label2.Position = [1 2 112 22];
            app.Label2.Text = '0.0';

            % Create PatientDropDownLabel
            app.PatientDropDownLabel = uilabel(app.UIFigure);
            app.PatientDropDownLabel.Position = [30 190 53 22];
            app.PatientDropDownLabel.Text = 'Patient';

            % Create PatientDropDown
            app.PatientDropDown = uidropdown(app.UIFigure);
            app.PatientDropDown.Items = {'44202', '54802', '63502', '112502'};
            app.PatientDropDown.BackgroundColor = [0.3294 0.7412 0.9412];
            app.PatientDropDown.Position = [141 190 158 22];
            app.PatientDropDown.Value = '44202';

            % Create DetectionModeCheckBox
            app.DetectionModeCheckBox = uicheckbox(app.UIFigure);
            app.DetectionModeCheckBox.Text = 'Detection Mode';
            app.DetectionModeCheckBox.Position = [30 124 121 27];

            % Create TrainTestButton
            app.TrainTestButton = uibutton(app.UIFigure, 'push');
            app.TrainTestButton.ButtonPushedFcn = createCallbackFcn(app, @TrainTestButtonPushed, true);
            app.TrainTestButton.BackgroundColor = [0.3294 0.7412 0.9412];
            app.TrainTestButton.FontColor = [1 1 1];
            app.TrainTestButton.Position = [52 95 79 22];
            app.TrainTestButton.Text = 'Train & Test';

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