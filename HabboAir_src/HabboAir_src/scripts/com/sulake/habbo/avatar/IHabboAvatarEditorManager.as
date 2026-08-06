package com.sulake.habbo.avatar
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IFrameController;
   import flash.events.IEventDispatcher;
   
   public interface IHabboAvatarEditorManager extends IUnknown
   {
      function openEditor(param1:uint, param2:UnknownIHabboAvatar2, param3:Array = null, param4:Boolean = false, param5:String = null, param6:String = "generic") : IFrameController;
      
      function embedEditorToContext(param1:uint, param2:IWindowController_1, param3:UnknownIHabboAvatar2 = null, param4:Array = null, param5:Boolean = false, param6:Boolean = false) : Boolean;
      
      function loadAvatarInEditor(param1:uint, param2:String, param3:String, param4:int = 0) : void;
      
      function loadOwnAvatarInEditor(param1:uint) : void;
      
      function get events() : IEventDispatcher;
      
      function close(param1:uint) : void;
   }
}

