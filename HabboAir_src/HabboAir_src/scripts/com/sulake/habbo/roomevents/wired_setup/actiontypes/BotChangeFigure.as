package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AvatarImagePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BotChangeFigure extends UnknownHabboRoomeventsWired_SetupActiontypes1
   {
      private static const STRING_PARAM_DELIMITER:String = "\t";
      
      private var _figureString:String = "";
      
      private var _botName:TextInputPreset;
      
      private var UnknownVarFromBotChangeFigure_AvatarImagePreset_1:AvatarImagePreset;
      
      private var UnknownVarFromBotChangeFigure_ButtonPreset_1:ButtonPreset;
      
      public function BotChangeFigure()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.BOT_CHANGE_FIGURE;
      }
      
      override public function readStringParamFromForm() : String
      {
         return _botName.text + "\t" + _figureString;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:Array = param1.stringParam.split("\t");
         var _loc2_:String = "";
         if(_loc3_.length > 0)
         {
            _loc2_ = _loc3_[0];
         }
         if(_loc3_.length > 1)
         {
            _figureString = _loc3_[1];
         }
         _botName.text = _loc2_;
         UnknownVarFromBotChangeFigure_AvatarImagePreset_1.figure = _figureString;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _botName = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.bot.name")));
         var _loc4_:SectionPreset = param1.createSection(l("bot.name"),_botName);
         UnknownVarFromBotChangeFigure_AvatarImagePreset_1 = param1.createAvatarImagePreset();
         UnknownVarFromBotChangeFigure_ButtonPreset_1 = param1.createButton(l("capture.figure"),captureFigure);
         var _loc5_:SectionPreset = param1.createSection(l("capture.figure"),param1.createSimpleListView(true,[UnknownVarFromBotChangeFigure_AvatarImagePreset_1.alignCenter(),UnknownVarFromBotChangeFigure_ButtonPreset_1]));
         param3.addElements(_loc4_,_loc5_);
      }
      
      private function captureFigure() : void
      {
         _figureString = roomEvents.sessionDataManager.figure;
         UnknownVarFromBotChangeFigure_AvatarImagePreset_1.figure = _figureString;
      }
   }
}

