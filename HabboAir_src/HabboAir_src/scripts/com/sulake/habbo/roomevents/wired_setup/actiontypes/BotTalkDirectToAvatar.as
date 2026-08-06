package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BotTalkDirectToAvatar extends UnknownHabboRoomeventsWired_SetupActiontypes1
   {
      private static const STRING_PARAM_DELIMITER:String = "\t";
      
      private var _botName:TextInputPreset;
      
      private var _chatMessage:TextAreaPreset;
      
      private var UnknownVarFromBotTalkDirectToAvatar_RadioGroupPreset_1:RadioGroupPreset;
      
      public function BotTalkDirectToAvatar()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.BOT_TALK_DIRECT_TO_AVTR;
      }
      
      override public function readStringParamFromForm() : String
      {
         return _botName.text + "\t" + _chatMessage.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         _botName.text = _loc2_.length >= 1 ? _loc2_[0] : "";
         _chatMessage.text = _loc2_.length == 2 ? _loc2_[1] : "";
         UnknownVarFromBotTalkDirectToAvatar_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromBotTalkDirectToAvatar_RadioGroupPreset_1.selected];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _botName = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.bot.name")));
         var _loc4_:SectionPreset = param1.createSection(l("bot.name"),_botName);
         _chatMessage = param1.createTextArea(new TextAreaParam(40,-1,8,-1,200,"${wiredfurni.tooltip.bot.chatmessage}"));
         UnknownVarFromBotTalkDirectToAvatar_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("whisper")),new RadioButtonParam(0,l("talk"))]);
         var _loc5_:SimpleListViewPreset = param1.createSimpleListView(true,[_chatMessage,UnknownVarFromBotTalkDirectToAvatar_RadioGroupPreset_1]);
         var _loc6_:SectionPreset = param1.createSection(l("message"),_loc5_);
         param3.addElements(_loc4_,_loc6_);
      }
   }
}

