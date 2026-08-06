package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.utils.IMargins;
   
   public interface IFrameController extends IWindowController_1
   {
      function get title() : ILabelWindow;
      
      function get header() : IHeaderController;
      
      function get content() : IWindowController_1;
      
      function get margins() : IMargins;
      
      function get scaler() : IScalerWindow;
      
      function resizeToFitContent() : void;
      
      function set helpButtonAction(param1:Function) : void;
      
      function get helpPage() : String;
      
      function set helpPage(param1:String) : void;
      
      function get menuButton() : UnknownICoreWindowComponents8;
      
      function get menuButtonVisible() : Boolean;
      
      function set menuButtonVisible(param1:Boolean) : *;
   }
}

