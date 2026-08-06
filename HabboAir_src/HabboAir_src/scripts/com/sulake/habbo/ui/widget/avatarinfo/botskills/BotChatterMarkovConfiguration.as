package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.CommandBotComposer;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.geom.Point;
   
   public class BotChatterMarkovConfiguration extends BotSkillConfigurationViewBase
   {
      public function BotChatterMarkovConfiguration(param1:AvatarInfoWidget)
      {
         super(param1);
      }
      
      private static function sanitizeBotChatString(param1:String) : String
      {
         var _loc2_:* = param1;
         return _loc2_.replace(/;#;/g," ");
      }
      
      override protected function get windowAssetName() : String
      {
         return "chatter_configuration_xml";
      }
      
      override protected function get skillType() : int
      {
         return 2;
      }
      
      override public function dispose() : void
      {
         close();
         super.dispose();
      }
      
      override public function open(param1:int, param2:Point = null) : void
      {
         super.open(param1,param2);
         _window.procedure = procedure;
      }
      
      override public function parseConfiguration(param1:String) : void
      {
         var _loc2_:Array = null;
         if(param1.indexOf(";#;") == -1)
         {
            _loc2_ = param1.split(";");
         }
         else
         {
            _loc2_ = param1.split(";#;");
         }
         if(_loc2_.length == 3 && _window)
         {
            text = _loc2_[0];
            autoChat = String(_loc2_[1]).toLowerCase() == "true" || _loc2_[1] == "1";
            chatDelay = int(_loc2_[2]);
            markovEnabled = false;
         }
         else if(_loc2_.length == 4 && _window)
         {
            text = _loc2_[0];
            autoChat = String(_loc2_[1]).toLowerCase() == "true" || _loc2_[1] == "1";
            chatDelay = int(_loc2_[2]);
            markovEnabled = String(_loc2_[3]).toLowerCase() == "true" || _loc2_[3] == "1";
         }
      }
      
      override protected function deactivateInputs() : void
      {
         _window.findChildByName("chat_text").deactivate();
         _window.findChildByName("auto_chat_checkbox").deactivate();
         _window.findChildByName("markov_checkbox").deactivate();
         _window.findChildByName("chat_delay_text").deactivate();
      }
      
      private function set text(param1:String) : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("chat_text"));
         _loc2_.text = param1;
         _loc2_.activate();
      }
      
      private function get text() : String
      {
         return ITextWindow(_window.findChildByName("chat_text")).text;
      }
      
      private function set autoChat(param1:Boolean) : void
      {
         var _loc2_:UnknownICoreWindowComponents2 = UnknownICoreWindowComponents2(_window.findChildByName("auto_chat_checkbox"));
         _loc2_.isSelected = param1;
         _loc2_.activate();
      }
      
      private function get autoChat() : Boolean
      {
         return UnknownICoreWindowComponents2(_window.findChildByName("auto_chat_checkbox")).isSelected;
      }
      
      private function set markovEnabled(param1:Boolean) : void
      {
         var _loc2_:UnknownICoreWindowComponents2 = UnknownICoreWindowComponents2(_window.findChildByName("markov_checkbox"));
         _loc2_.isSelected = param1;
         _loc2_.activate();
      }
      
      private function get markovEnabled() : Boolean
      {
         return UnknownICoreWindowComponents2(_window.findChildByName("markov_checkbox")).isSelected;
      }
      
      private function set chatDelay(param1:int) : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("chat_delay_text"));
         _loc2_.text = param1.toString();
         _loc2_.activate();
      }
      
      private function get chatDelay() : int
      {
         return int(ITextWindow(_window.findChildByName("chat_delay_text")).text);
      }
      
      private function get botCommandString() : String
      {
         return sanitizeBotChatString(text) + ";#;" + autoChat + ";#;" + chatDelay + ";#;" + markovEnabled;
      }
      
      private function procedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "save_button":
                  UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.handler.container.connection.send(new CommandBotComposer(UnknownVarFromBotSkillConfigurationViewBase_Int_1,2,botCommandString));
                  close();
                  break;
               case "cancel_button":
                  close();
                  break;
               case "help_link":
                  HabboWebTools.navigateToURL(UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.configuration.getProperty("link.format.bots.help"),"habboMain");
            }
         }
      }
   }
}

