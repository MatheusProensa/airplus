package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.geom.Point;
   
   public interface IBotSkillConfigurationViewBase extends IComponentInterfaceQueue
   {
      function open(param1:int, param2:Point = null) : void;
      
      function close() : void;
      
      function parseConfiguration(param1:String) : void;
   }
}

