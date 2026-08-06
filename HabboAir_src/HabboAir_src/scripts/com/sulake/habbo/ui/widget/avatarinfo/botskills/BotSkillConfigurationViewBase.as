package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.messages.incoming.room.bots.BotCommandConfigurationEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BotSkillConfigurationViewBase implements IBotSkillConfigurationViewBase
   {
      private var UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1:IMessageEvent;
      
      protected var UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1:AvatarInfoWidget;
      
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromBotSkillConfigurationViewBase_Int_1:int;
      
      public function BotSkillConfigurationViewBase(param1:AvatarInfoWidget)
      {
         super();
         UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1)
         {
            if(UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.handler.container.connection && UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1)
            {
               UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.handler.container.connection.removeMessageEvent(UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1);
               UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1 = null;
            }
            UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1 = null;
         }
         UnknownVarFromBotSkillConfigurationViewBase_Int_1 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1 == null;
      }
      
      public function open(param1:int, param2:Point = null) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Rectangle = null;
         UnknownVarFromBotSkillConfigurationViewBase_Int_1 = param1;
         if(!UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1)
         {
            UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1 = new BotCommandConfigurationEvent(onBotCommandConfigurationEvent);
            UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.handler.container.connection.addMessageEvent(UnknownVarFromBotSkillConfigurationViewBase_IMessageEvent_1);
         }
         UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.handler.container.connection.send(new GetBotCommandConfigurationDataComposer(UnknownVarFromBotSkillConfigurationViewBase_Int_1,skillType));
         if(!_window)
         {
            _loc3_ = UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.assets.getAssetByName(windowAssetName).content as XML;
            _window = UnknownVarFromBotSkillConfigurationViewBase_AvatarInfoWidget_1.windowManager.buildFromXML(_loc3_,1) as IWindowController_1;
         }
         if(param2)
         {
            _loc4_ = _window.rectangle;
            _window.x = param2.x - _loc4_.width / 2;
            _window.y = param2.y - _loc4_.height;
         }
         fitToScreen();
         _window.visible = true;
         deactivateInputs();
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function parseConfiguration(param1:String) : void
      {
      }
      
      protected function deactivateInputs() : void
      {
      }
      
      protected function get windowAssetName() : String
      {
         return "";
      }
      
      protected function get skillType() : int
      {
         return -1;
      }
      
      private function onBotCommandConfigurationEvent(param1:BotCommandConfigurationEvent) : void
      {
         if(param1.getParser().botId == UnknownVarFromBotSkillConfigurationViewBase_Int_1 && param1.getParser().commandId == skillType)
         {
            parseConfiguration(param1.getParser().data);
         }
      }
      
      private function fitToScreen() : void
      {
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         if(_loc1_.top < 0)
         {
            _window.y += -_loc1_.top;
         }
         if(_loc1_.left < 0)
         {
            _window.x += -_loc1_.left;
         }
         if(_loc1_.right > _window.desktop.width)
         {
            _window.x -= _loc1_.right - _window.desktop.width;
         }
         if(_loc1_.bottom > _window.desktop.height)
         {
            _window.y -= _loc1_.bottom - _window.desktop.height;
         }
      }
   }
}

