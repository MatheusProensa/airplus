package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle2;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public interface IHabboFreeFlowChat extends IUnknown
   {
      function get displayObject() : DisplayObject;
      
      function get chatStyleLibrary() : UnknownIHabboFreeflowchatStyle2;
      
      function get preferedChatStyle() : int;
      
      function set preferedChatStyle(param1:int) : void;
      
      function get chatFontSizeMode() : int;
      
      function set chatFontSizeMode(param1:int) : void;
      
      function get chatMode() : int;
      
      function set chatMode(param1:int) : void;
      
      function get chatBubbleWidth() : int;
      
      function set chatBubbleWidth(param1:int) : void;
      
      function get chatScrollSpeed() : int;
      
      function set chatScrollSpeed(param1:int) : void;
      
      function updateChatPreferences(param1:int, param2:int, param3:int) : void;
      
      function createPreviewBitmap(param1:String, param2:int) : BitmapData;
      
      function clear() : void;
      
      function toggleVisibility() : void;
      
      function set visible(param1:Boolean) : void;
      
      function isNotificationStyle(param1:int) : Boolean;
   }
}

