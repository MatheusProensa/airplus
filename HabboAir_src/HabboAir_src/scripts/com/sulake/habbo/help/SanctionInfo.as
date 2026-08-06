package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MySanctionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MySanctionStatusMessageParser;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.SanctionDTO;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.SanctionType;
   import com.sulake.habbo.utils.StringUtil;
   
   public class SanctionInfo implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _window:IWindowController_1;
      
      private var _habboHelp:HabboHelp;
      
      public function SanctionInfo(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function openWindow(param1:MySanctionStatusMessageEvent) : void
      {
         var _loc10_:ITextWindow = null;
         var _loc5_:int = 0;
         var _loc2_:ITextWindow = null;
         var _loc7_:String = null;
         var _loc4_:IWindowModel = null;
         dispose();
         _disposed = false;
         _window = _habboHelp.getXmlWindow("sanction_info") as IWindowController_1;
         _window.center();
         _window.procedure = windowEventHandler;
         var _loc3_:MySanctionStatusMessageParser = !!param1 ? param1.getParser() : null;
         var _loc8_:IItemListWindow = _window.findChildByName("main_contents_list") as IItemListWindow;
         var _loc6_:ITextWindow = _window.findChildByName("sanction_info") as ITextWindow;
         var _loc11_:IWindowModel = _window.findChildByName("divider");
         if(!_loc8_ || !_loc6_)
         {
            return;
         }
         var _loc9_:Array = buildSanctionDescriptions(!!_loc3_ ? _loc3_.sanctions : null);
         _loc8_.removeListItems();
         if(_loc9_.length == 0)
         {
            _loc10_ = ITextWindow(_loc6_.clone());
            _loc10_.caption = _habboHelp.localization.getLocalization("settings.help.sanction_information.description");
            _loc10_.height = _loc10_.textHeight + 10;
            _loc8_.addListItem(_loc10_);
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc2_ = ITextWindow(_loc6_.clone());
               _loc7_ = _loc9_[_loc5_];
               if(_loc5_ > 0)
               {
                  _loc7_ = "\n" + _loc7_ + "\n";
               }
               if(_loc5_ < _loc9_.length - 1)
               {
                  _loc7_ += "\n";
               }
               _loc2_.caption = _loc7_;
               _loc2_.height = _loc2_.textHeight + 10;
               _loc8_.addListItem(_loc2_);
               if(_loc5_ < _loc9_.length - 1 && _loc11_)
               {
                  _loc4_ = _loc11_.clone();
                  _loc8_.addListItem(_loc4_);
               }
               _loc5_++;
            }
         }
         _loc8_.arrangeListItems();
      }
      
      private function buildSanctionDescriptions(param1:Array) : Array
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Array = [];
         if(!param1 || param1.length == 0)
         {
            return _loc5_;
         }
         for each(var _loc2_ in param1)
         {
            _loc3_ = !!_loc2_ ? _loc2_.UnknownVarFromSanctionDTO_String_1 : null;
            if(!StringUtil.isEmpty(_loc3_))
            {
               _loc4_ = [_loc3_];
               if(_loc2_ && _loc2_.UnknownVarFromSanctionDTO_Boolean_1)
               {
                  appendGradualSanctionDetails(_loc4_,_loc2_);
               }
               _loc5_.push(_loc4_.join("\n"));
            }
         }
         return _loc5_;
      }
      
      private function appendGradualSanctionDetails(param1:Array, param2:SanctionDTO) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc5_:Boolean = param2 && param2.UnknownVarFromSanctionDTO_Int_1 > 0;
         var _loc4_:String = param2 && param2.UnknownVarFromSanctionDTO_SanctionType_2 ? param2.UnknownVarFromSanctionDTO_SanctionType_2.name : "";
         if(!_loc5_ && StringUtil.isEmpty(_loc4_))
         {
            return;
         }
         param1.push("");
         param1.push(_habboHelp.localization.getLocalization("help.sanction.probation.reminder"));
         if(_loc5_)
         {
            _loc3_ = getProbationDaysLeft(param2);
            param1.push(_habboHelp.localization.getLocalization("help.sanction.probation.days.left") + " " + _loc3_);
         }
         if(!StringUtil.isEmpty(_loc4_))
         {
            param1.push("");
            param1.push(getNextSanctionDescription(param2.UnknownVarFromSanctionDTO_SanctionType_2));
            param1.push("");
         }
      }
      
      private function getProbationDaysLeft(param1:SanctionDTO) : int
      {
         if(!param1 || param1.UnknownVarFromSanctionDTO_Int_1 <= 0)
         {
            return 0;
         }
         return int(Math.ceil(param1.UnknownVarFromSanctionDTO_Int_1 / 24));
      }
      
      private function getNextSanctionDescription(param1:SanctionType) : String
      {
         var _loc2_:int = 0;
         if(!param1 || StringUtil.isEmpty(param1.name))
         {
            return "";
         }
         switch(param1.name)
         {
            case "ALERT":
               return _habboHelp.localization.getLocalization("help.sanction.next.alert");
            case "MUTE":
               return _habboHelp.localization.registerParameter("help.sanction.next.mute","hours",param1.UnknownVarFromSanctionType_Int_1.toString());
            case "BAN_PERMANENT":
               return _habboHelp.localization.getLocalization("help.sanction.next.permban");
            default:
               if(param1.UnknownVarFromSanctionType_Int_1 > 24)
               {
                  _loc2_ = param1.UnknownVarFromSanctionType_Int_1 / 24;
                  return _habboHelp.localization.registerParameter("help.sanction.next.ban.days","days",_loc2_.toString());
               }
               return _habboHelp.localization.registerParameter("help.sanction.next.ban","hours",param1.UnknownVarFromSanctionType_Int_1.toString());
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK" || !param2)
         {
            return;
         }
         switch(param2.name)
         {
            case "faq_link":
               _habboHelp.openCfhFaq();
               break;
            case "header_button_close":
            case "ok_button":
               dispose();
         }
      }
   }
}

