package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BotFollowAvatar extends UnknownHabboRoomeventsWired_SetupActiontypes1
   {
      private var _botName:TextInputPreset;
      
      private var UnknownVarFromBotFollowAvatar_RadioGroupPreset_1:RadioGroupPreset;
      
      public function BotFollowAvatar()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.BOT_FOLLOW_AVATAR;
      }
      
      override public function readStringParamFromForm() : String
      {
         return _botName.text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromBotFollowAvatar_RadioGroupPreset_1.selected];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _botName.text = param1.stringParam;
         UnknownVarFromBotFollowAvatar_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _botName = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.bot.name")));
         UnknownVarFromBotFollowAvatar_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("start.following")),new RadioButtonParam(0,l("stop.following"))]);
         var _loc5_:SimpleListViewPreset = param1.createSimpleListView(true,[_botName,UnknownVarFromBotFollowAvatar_RadioGroupPreset_1]);
         var _loc4_:SectionPreset = param1.createSection(l("bot.name"),_loc5_);
         param3.addElements(_loc4_);
      }
   }
}

