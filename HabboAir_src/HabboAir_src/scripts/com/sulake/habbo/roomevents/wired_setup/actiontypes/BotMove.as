package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BotMove extends UnknownHabboRoomeventsWired_SetupActiontypes1
   {
      private var _botName:TextInputPreset;
      
      public function BotMove()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.BOT_MOVE;
      }
      
      override public function readStringParamFromForm() : String
      {
         return _botName.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _botName.text = param1.stringParam;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _botName = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.bot.name")));
         var _loc4_:SectionPreset = param1.createSection(l("bot.name"),_botName);
         param3.addElements(_loc4_);
      }
   }
}

