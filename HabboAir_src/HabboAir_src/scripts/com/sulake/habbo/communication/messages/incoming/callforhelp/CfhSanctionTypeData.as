package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.moderation.IRoomData;
   
   [SecureSWF(rename="true")]
   public class CfhSanctionTypeData implements IRoomData
   {
      private var _name:String;
      
      private var _sanctionLengthInHours:int;
      
      private var UnknownVarFromCfhSanctionTypeData_Int_1:int;
      
      private var _avatarOnly:Boolean;
      
      private var _tradeLockInfo:String = "";
      
      private var _machineBanInfo:String = "";
      
      public function CfhSanctionTypeData(param1:IMessageDataWrapper)
      {
         super();
         _name = param1.readString();
         _sanctionLengthInHours = param1.readInteger();
         UnknownVarFromCfhSanctionTypeData_Int_1 = param1.readInteger();
         _avatarOnly = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _tradeLockInfo = param1.readString();
         }
         if(param1.bytesAvailable)
         {
            _machineBanInfo = param1.readString();
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get sanctionLengthInHours() : int
      {
         return _sanctionLengthInHours;
      }
      
      public function get avatarOnly() : Boolean
      {
         return _avatarOnly;
      }
      
      public function get tradeLockInfo() : String
      {
         return _tradeLockInfo;
      }
      
      public function get machineBanInfo() : String
      {
         return _machineBanInfo;
      }
   }
}

