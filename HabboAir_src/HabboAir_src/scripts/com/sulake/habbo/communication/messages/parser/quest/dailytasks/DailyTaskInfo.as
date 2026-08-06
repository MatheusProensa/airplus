package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class DailyTaskInfo
   {
      public static var UnknownVarFromDailyTaskInfo_Int_1:int = 0;
      
      public static var UnknownVarFromDailyTaskInfo_Int_2:int = 1;
      
      public static var UnknownVarFromDailyTaskInfo_Int_3:int = 2;
      
      private var _taskId:Number;
      
      private var _taskCode:String;
      
      private var _questTypeCode:String;
      
      private var _isBonus:Boolean;
      
      private var _imageVersion:String;
      
      private var _catalogName:String;
      
      private var _requiredRepeats:int;
      
      private var _repeats:int;
      
      private var _status:int;
      
      private var UnknownVarFromDailyTaskInfo_Int_4:int;
      
      private var UnknownVarFromDailyTaskInfo_Date_1:Date;
      
      private var _rewards:Vector.<DailyTaskReward>;
      
      public function DailyTaskInfo(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         UnknownVarFromDailyTaskInfo_Date_1 = new Date();
         super();
         _taskId = param1.readLong();
         _taskCode = param1.readString();
         _questTypeCode = param1.readString();
         _isBonus = param1.readBoolean();
         _imageVersion = param1.readString();
         _catalogName = param1.readString();
         _requiredRepeats = param1.readInteger();
         _repeats = param1.readInteger();
         _status = param1.readByte();
         UnknownVarFromDailyTaskInfo_Int_4 = param1.readInteger();
         _rewards = new Vector.<DailyTaskReward>();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _rewards.push(new DailyTaskReward(param1));
            _loc2_ += 1;
         }
      }
      
      public function get taskId() : Number
      {
         return _taskId;
      }
      
      public function get taskCode() : String
      {
         return _taskCode;
      }
      
      public function get questTypeCode() : String
      {
         return _questTypeCode;
      }
      
      public function get isBonus() : Boolean
      {
         return _isBonus;
      }
      
      public function get imageVersion() : String
      {
         return _imageVersion;
      }
      
      public function get catalogName() : String
      {
         return _catalogName;
      }
      
      public function get requiredRepeats() : int
      {
         return _requiredRepeats;
      }
      
      public function get repeats() : int
      {
         return _repeats;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get secondsLeft() : int
      {
         if(UnknownVarFromDailyTaskInfo_Int_4 <= 0)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = (_loc1_.getTime() - UnknownVarFromDailyTaskInfo_Date_1.getTime()) / 1000;
         return UnknownVarFromDailyTaskInfo_Int_4 - _loc2_;
      }
      
      public function get isExpired() : Boolean
      {
         return UnknownVarFromDailyTaskInfo_Int_4 < 0 && _status != UnknownVarFromDailyTaskInfo_Int_1;
      }
      
      public function get rewards() : Vector.<DailyTaskReward>
      {
         return _rewards;
      }
      
      public function set repeats(param1:int) : void
      {
         _repeats = param1;
      }
      
      public function set status(param1:int) : void
      {
         _status = param1;
      }
      
      public function get nameLocalizationKey() : String
      {
         return "dailytask." + _taskCode + ".name";
      }
      
      public function get descriptionLocalizationKey() : String
      {
         return "dailytask." + _taskCode + ".desc";
      }
      
      public function get hintLocalizationKey() : String
      {
         return "dailytask." + _taskCode + ".hint";
      }
   }
}

