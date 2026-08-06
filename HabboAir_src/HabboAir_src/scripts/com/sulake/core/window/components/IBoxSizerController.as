package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IBoxSizerController extends IWindowController_1
   {
      function setHorizontalPadding(param1:int) : void;
      
      function setVerticalPadding(param1:int) : void;
      
      function setSpacing(param1:int) : void;
      
      function setVertical(param1:Boolean) : void;
      
      function setAutoRearrange(param1:Boolean) : void;
      
      function getAutoRearrange() : Boolean;
   }
}

