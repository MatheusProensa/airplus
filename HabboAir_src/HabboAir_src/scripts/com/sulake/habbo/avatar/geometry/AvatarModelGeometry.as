package com.sulake.habbo.avatar.geometry
{
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import flash.utils.Dictionary;
   
   public class AvatarModelGeometry
   {
      private var UnknownVarFromAvatarModelGeometry_AvatarSet_1:AvatarSet;
      
      private var _geometryTypes:Dictionary;
      
      private var UnknownVarFromAvatarModelGeometry_Dictionary_1:Dictionary;
      
      private var UnknownVarFromAvatarModelGeometry_Dictionary_2:Dictionary;
      
      private var UnknownVarFromAvatarModelGeometry_Dictionary_3:Dictionary;
      
      private var UnknownVarFromAvatarModelGeometry_Matrix4x4_1:Matrix4x4;
      
      private var _camera:Vector3D;
      
      private var _canvases:Dictionary;
      
      public function AvatarModelGeometry(param1:XML)
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc2_:* = null;
         var _loc11_:* = null;
         var _loc12_:AvatarCanvas = null;
         var _loc6_:String = null;
         var _loc4_:Dictionary = null;
         var _loc16_:* = null;
         var _loc7_:Dictionary = null;
         var _loc5_:Dictionary = null;
         var _loc3_:* = null;
         var _loc9_:GeometryBodyPart = null;
         var _loc10_:String = null;
         _camera = new Vector3D(0,0,10);
         super();
         UnknownVarFromAvatarModelGeometry_Matrix4x4_1 = new Matrix4x4();
         _geometryTypes = new Dictionary();
         UnknownVarFromAvatarModelGeometry_Dictionary_1 = new Dictionary();
         UnknownVarFromAvatarModelGeometry_Dictionary_2 = new Dictionary();
         UnknownVarFromAvatarModelGeometry_Dictionary_3 = new Dictionary();
         UnknownVarFromAvatarModelGeometry_AvatarSet_1 = new AvatarSet(param1.avatarset[0]);
         _canvases = new Dictionary();
         var _loc8_:XML = param1.camera[0];
         if(_loc8_ != null)
         {
            _loc13_ = parseFloat(_loc8_.x.text());
            _loc14_ = parseFloat(_loc8_.y.text());
            _loc15_ = parseFloat(_loc8_.z.text());
            _camera.x = _loc13_;
            _camera.y = _loc14_;
            _camera.z = _loc15_;
         }
         for each(_loc2_ in param1.canvas)
         {
            _loc6_ = String(_loc2_.@scale);
            _loc4_ = new Dictionary();
            for each(_loc11_ in _loc2_.geometry)
            {
               _loc12_ = new AvatarCanvas(_loc11_,_loc6_);
               _loc4_[String(_loc11_.@id)] = _loc12_;
            }
            _canvases[_loc6_] = _loc4_;
         }
         for each(_loc16_ in param1.type)
         {
            _loc7_ = new Dictionary();
            _loc5_ = new Dictionary();
            for each(_loc3_ in _loc16_.bodypart)
            {
               _loc9_ = new GeometryBodyPart(_loc3_);
               _loc7_[String(_loc3_.@id)] = _loc9_;
               _loc10_ = String(_loc3_.@id);
               if(_loc3_["order-before"] != undefined && String(_loc3_["order-before"]) != "")
               {
                  UnknownVarFromAvatarModelGeometry_Dictionary_2[_loc10_] = String(_loc3_["order-before"]);
               }
               if(_loc3_["order-after"] != undefined && String(_loc3_["order-after"]) != "")
               {
                  UnknownVarFromAvatarModelGeometry_Dictionary_3[_loc10_] = String(_loc3_["order-after"]);
               }
               for each(var _loc17_ in _loc9_.getPartIds(null))
               {
                  _loc5_[_loc17_] = _loc9_;
               }
            }
            _geometryTypes[String(_loc16_.@id)] = _loc7_;
            UnknownVarFromAvatarModelGeometry_Dictionary_1[String(_loc16_.@id)] = _loc5_;
         }
      }
      
      public function removeDynamicItems(param1:IAvatarImage_2) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(_loc2_ in _geometryTypes)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.removeDynamicParts(param1);
            }
         }
      }
      
      public function getBodyPartIdsInAvatarSet(param1:String) : Array
      {
         var _loc3_:Array = [];
         var _loc2_:AvatarSet = UnknownVarFromAvatarModelGeometry_AvatarSet_1.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getBodyParts();
         }
         return _loc3_;
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         var _loc2_:AvatarSet = UnknownVarFromAvatarModelGeometry_AvatarSet_1.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            return _loc2_.isMain;
         }
         return false;
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         var _loc4_:AvatarCanvas = null;
         var _loc3_:Dictionary = _canvases[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_[param2] as AvatarCanvas;
         }
         return _loc4_;
      }
      
      private function typeExists(param1:String) : Boolean
      {
         return _geometryTypes[param1] != null;
      }
      
      private function hasBodyPart(param1:String, param2:String) : Boolean
      {
         var _loc3_:Dictionary = null;
         if(typeExists(param1))
         {
            _loc3_ = _geometryTypes[param1] as Dictionary;
            return _loc3_[param2] != null;
         }
         return false;
      }
      
      private function getBodyPartIDs(param1:String) : Array
      {
         var _loc4_:Dictionary = getBodyPartsOfType(param1);
         var _loc2_:Array = [];
         for(var _loc3_ in _geometryTypes)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function getBodyPartsOfType(param1:String) : Dictionary
      {
         if(typeExists(param1))
         {
            return _geometryTypes[param1] as Dictionary;
         }
         return new Dictionary();
      }
      
      public function getBodyPart(param1:String, param2:String) : GeometryBodyPart
      {
         var _loc3_:Dictionary = getBodyPartsOfType(param1);
         return _loc3_[param2];
      }
      
      public function getBodyPartOfItem(param1:String, param2:String, param3:IAvatarImage_2) : GeometryBodyPart
      {
         var _loc6_:GeometryBodyPart = null;
         var _loc5_:Dictionary = null;
         var _loc4_:Dictionary = UnknownVarFromAvatarModelGeometry_Dictionary_1[param1];
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_[param2];
            if(_loc6_ != null)
            {
               return _loc6_;
            }
            _loc5_ = getBodyPartsOfType(param1);
            for each(_loc6_ in _loc5_)
            {
               if(_loc6_.hasPart(param2,param3))
               {
                  return _loc6_;
               }
            }
         }
         return null;
      }
      
      private function getBodyPartsInAvatarSet(param1:Dictionary, param2:String) : Array
      {
         var _loc6_:GeometryBodyPart = null;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc3_:Array = this.getBodyPartIdsInAvatarSet(param2);
         for each(_loc4_ in _loc3_)
         {
            _loc6_ = param1[_loc4_];
            if(_loc6_ != null)
            {
               _loc5_.push(_loc6_);
            }
         }
         return _loc5_;
      }
      
      private function placeBodyPartBefore(param1:Array, param2:String, param3:String) : void
      {
         var _loc5_:int = int(param1.indexOf(param2));
         if(_loc5_ == -1)
         {
            return;
         }
         param1.splice(_loc5_,1);
         var _loc4_:int = int(param1.indexOf(param3));
         if(_loc4_ == -1)
         {
            return;
         }
         param1.splice(_loc4_,0,param2);
      }
      
      private function placeBodyPartAfter(param1:Array, param2:String, param3:String) : void
      {
         var _loc5_:int = int(param1.indexOf(param2));
         if(_loc5_ == -1)
         {
            return;
         }
         param1.splice(_loc5_,1);
         var _loc4_:int = int(param1.indexOf(param3));
         if(_loc4_ == -1)
         {
            return;
         }
         param1.splice(_loc4_ + 1,0,param2);
      }
      
      public function getBodyPartsAtAngle(param1:String, param2:uint, param3:String) : Array
      {
         var _loc12_:GeometryBodyPart = null;
         var _loc8_:Number = NaN;
         var _loc9_:* = null;
         if(param3 == null)
         {
            Logger.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
            return [];
         }
         var _loc4_:Dictionary = getBodyPartsOfType(param3);
         var _loc7_:Array = getBodyPartsInAvatarSet(_loc4_,param1);
         var _loc10_:Array = [];
         var _loc5_:Array = [];
         UnknownVarFromAvatarModelGeometry_Matrix4x4_1 = Matrix4x4.getYRotationMatrix(param2);
         for each(_loc12_ in _loc7_)
         {
            _loc12_.applyTransform(UnknownVarFromAvatarModelGeometry_Matrix4x4_1);
            _loc8_ = _loc12_.getDistance(_camera);
            _loc10_.push([_loc8_,_loc12_]);
         }
         _loc10_.sort(orderByDistance);
         for each(_loc9_ in _loc10_)
         {
            _loc12_ = _loc9_[1] as GeometryBodyPart;
            _loc5_.push(_loc12_.id);
         }
         for(var _loc6_ in UnknownVarFromAvatarModelGeometry_Dictionary_2)
         {
            placeBodyPartBefore(_loc5_,_loc6_,UnknownVarFromAvatarModelGeometry_Dictionary_2[_loc6_]);
         }
         for(var _loc11_ in UnknownVarFromAvatarModelGeometry_Dictionary_3)
         {
            placeBodyPartAfter(_loc5_,_loc11_,UnknownVarFromAvatarModelGeometry_Dictionary_3[_loc11_]);
         }
         return _loc5_;
      }
      
      public function getParts(param1:String, param2:String, param3:uint, param4:Array, param5:IAvatarImage_2) : Array
      {
         var _loc6_:GeometryBodyPart = null;
         if(hasBodyPart(param1,param2))
         {
            _loc6_ = getBodyPartsOfType(param1)[param2] as GeometryBodyPart;
            UnknownVarFromAvatarModelGeometry_Matrix4x4_1 = Matrix4x4.getYRotationMatrix(param3);
            return _loc6_.getParts(UnknownVarFromAvatarModelGeometry_Matrix4x4_1,_camera,param4,param5);
         }
         return [];
      }
      
      private function orderByDistance(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}

