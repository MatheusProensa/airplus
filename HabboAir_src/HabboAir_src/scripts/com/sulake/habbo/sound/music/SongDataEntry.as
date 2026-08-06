package com.sulake.habbo.sound.music
{
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
   import com.sulake.habbo.sound.IHabboSoundBase_1;
   import com.sulake.habbo.sound.ISongInfo;
   
   public class SongDataEntry extends PlayListEntry implements ISongInfo
   {
      private var _soundObject:IHabboSoundBase_1 = null;
      
      private var _songData:String = "";
      
      private var _diskId:int = -1;
      
      public function SongDataEntry(param1:int, param2:int, param3:String, param4:String, param5:IHabboSoundBase_1)
      {
         _soundObject = param5;
         super(param1,param2,param3,param4);
      }
      
      override public function get id() : int
      {
         return _id;
      }
      
      override public function get length() : int
      {
         return _length;
      }
      
      override public function get name() : String
      {
         return _songName;
      }
      
      override public function get creator() : String
      {
         return _creator;
      }
      
      public function get loaded() : Boolean
      {
         return _soundObject?.ready;
      }
      
      public function get soundObject() : IHabboSoundBase_1
      {
         return _soundObject;
      }
      
      public function get songData() : String
      {
         return _songData;
      }
      
      public function get diskId() : int
      {
         return _diskId;
      }
      
      public function set soundObject(param1:IHabboSoundBase_1) : void
      {
         _soundObject = param1;
      }
      
      public function set songData(param1:String) : void
      {
         _songData = param1;
      }
      
      public function set diskId(param1:int) : void
      {
         _diskId = param1;
      }
   }
}

