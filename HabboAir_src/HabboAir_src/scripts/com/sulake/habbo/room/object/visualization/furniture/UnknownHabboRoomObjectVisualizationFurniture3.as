package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObjectModel;
   
   public class UnknownHabboRoomObjectVisualizationFurniture3 extends ExternalIsometricImageFurniVisualization
   {
      protected static const THUMBNAIL_URL_KEY:String = "THUMBNAIL_URL";
      
      public function UnknownHabboRoomObjectVisualizationFurniture3()
      {
         super();
      }
      
      override protected function getThumbnailURL() : String
      {
         var _loc3_:IRoomObjectModel = object.getModel();
         var _loc2_:Map = _loc3_.getStringToStringMap("furniture_data");
         var _loc1_:String = _loc3_.getString("session_url_prefix");
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_ + _loc2_.getValue("THUMBNAIL_URL");
      }
   }
}

