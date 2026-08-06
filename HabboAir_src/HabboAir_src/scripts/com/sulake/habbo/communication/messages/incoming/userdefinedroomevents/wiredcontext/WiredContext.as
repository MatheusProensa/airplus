package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.AllVariablesInRoom;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedGlobalPlaceholderList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedVariableList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndHolders;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndValue;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableList;
   
   public class WiredContext
   {
      public static var UnknownConstFromUnknownHabboInventoryEnum4_String_1:WiredContext = new WiredContext(null);
      
      private var _roomVariablesList:AllVariablesInRoom = null;
      
      private var _furniVariableInfo:VariableInfoAndHolders = null;
      
      private var _userVariableInfo:VariableInfoAndHolders = null;
      
      private var _globalVariableInfo:VariableInfoAndValue = null;
      
      private var _rulesetVariables:VariableList = null;
      
      private var _referenceVariablesList:SharedVariableList = null;
      
      private var _referencePlaceholderList:SharedGlobalPlaceholderList = null;
      
      public function WiredContext(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.readInteger();
            switch(_loc2_)
            {
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_1:
                  _roomVariablesList = new AllVariablesInRoom(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_2:
                  _furniVariableInfo = new VariableInfoAndHolders(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_3:
                  _userVariableInfo = new VariableInfoAndHolders(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_4:
                  _globalVariableInfo = new VariableInfoAndValue(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_5:
                  _referenceVariablesList = new SharedVariableList(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_6:
                  _rulesetVariables = VariableList.createFromMessage(param1);
                  break;
               case UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontext1_Int_7:
                  _referencePlaceholderList = new SharedGlobalPlaceholderList(param1);
            }
            _loc3_++;
         }
      }
      
      public function get roomVariablesList() : AllVariablesInRoom
      {
         return _roomVariablesList;
      }
      
      public function get furniVariableInfo() : VariableInfoAndHolders
      {
         return _furniVariableInfo;
      }
      
      public function get userVariableInfo() : VariableInfoAndHolders
      {
         return _userVariableInfo;
      }
      
      public function get globalVariableInfo() : VariableInfoAndValue
      {
         return _globalVariableInfo;
      }
      
      public function get referenceVariablesList() : SharedVariableList
      {
         return _referenceVariablesList;
      }
      
      public function get referencePlaceholderList() : SharedGlobalPlaceholderList
      {
         return _referencePlaceholderList;
      }
      
      public function get rulesetVariables() : VariableList
      {
         return _rulesetVariables;
      }
   }
}

