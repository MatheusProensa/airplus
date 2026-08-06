package com.sulake.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.renderer.IRoomRendererBase;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class RoomInstance implements IRoomInstance
   {
      private var UnknownVarFromRoomInstance_Dictionary_1:Dictionary;
      
      private var UnknownVarFromRoomInstance_Dictionary_2:Dictionary;
      
      private var UnknownVarFromRoomInstance_Array_1:Array;
      
      private var UnknownVarFromRoomInstance_Array_2:Array;
      
      private var _managers:Map;
      
      private var _updateCategories:Array;
      
      private var _renderer:IRoomRendererBase;
      
      private var _container:IRoomInstanceContainer;
      
      private var _id:String;
      
      public function RoomInstance(param1:String, param2:IRoomInstanceContainer)
      {
         super();
         _managers = new Map();
         _updateCategories = [];
         _container = param2;
         _id = param1;
         UnknownVarFromRoomInstance_Dictionary_1 = new Dictionary();
         UnknownVarFromRoomInstance_Dictionary_2 = new Dictionary();
         UnknownVarFromRoomInstance_Array_1 = [];
         UnknownVarFromRoomInstance_Array_2 = [];
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectManager = null;
         var _loc3_:String = null;
         if(_managers != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _managers.length)
            {
               _loc1_ = _managers.getWithIndex(_loc2_) as IRoomObjectManager;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _managers.dispose();
            _managers = null;
         }
         if(_renderer != null)
         {
            _renderer.dispose();
            _renderer = null;
         }
         _container = null;
         _updateCategories = null;
         if(UnknownVarFromRoomInstance_Dictionary_1 != null)
         {
            for(_loc3_ in UnknownVarFromRoomInstance_Dictionary_1)
            {
               delete UnknownVarFromRoomInstance_Dictionary_1[_loc3_];
            }
            UnknownVarFromRoomInstance_Dictionary_1 = null;
         }
         if(UnknownVarFromRoomInstance_Dictionary_2 != null)
         {
            for(_loc3_ in UnknownVarFromRoomInstance_Dictionary_2)
            {
               delete UnknownVarFromRoomInstance_Dictionary_2[_loc3_];
            }
            UnknownVarFromRoomInstance_Dictionary_2 = null;
         }
         UnknownVarFromRoomInstance_Array_2 = [];
         UnknownVarFromRoomInstance_Array_1 = [];
      }
      
      public function hasValueForName(param1:String) : Boolean
      {
         return param1 in UnknownVarFromRoomInstance_Dictionary_1;
      }
      
      public function getNumber(param1:String) : Number
      {
         return UnknownVarFromRoomInstance_Dictionary_1[param1];
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(UnknownVarFromRoomInstance_Array_1.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomInstance_Array_1.push(param1);
         }
         if(UnknownVarFromRoomInstance_Dictionary_1[param1] != param2)
         {
            UnknownVarFromRoomInstance_Dictionary_1[param1] = param2;
         }
      }
      
      public function getString(param1:String) : String
      {
         return UnknownVarFromRoomInstance_Dictionary_2[param1];
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(UnknownVarFromRoomInstance_Array_2.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomInstance_Array_2.push(param1);
         }
         if(UnknownVarFromRoomInstance_Dictionary_2[param1] != param2)
         {
            UnknownVarFromRoomInstance_Dictionary_2[param1] = param2;
         }
      }
      
      public function addObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = int(_updateCategories.indexOf(param1));
         if(_loc2_ >= 0)
         {
            return;
         }
         _updateCategories.push(param1);
      }
      
      public function removeObjectUpdateCategory(param1:int) : void
      {
         var _loc2_:int = int(_updateCategories.indexOf(param1));
         if(_loc2_ >= 0)
         {
            _updateCategories.splice(_loc2_,1);
         }
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:IRoomObjectManager = null;
         var _loc4_:int = 0;
         var _loc7_:IRoomObjectController = null;
         var _loc5_:IRoomObjectEventHandler = null;
         var _loc1_:int = getTimer();
         _loc3_ = _updateCategories.length - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = int(_updateCategories[_loc3_]);
            _loc2_ = getObjectManager(_loc6_);
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.getObjectCount() - 1;
               while(_loc4_ >= 0)
               {
                  _loc7_ = _loc2_.getObjectWithIndex(_loc4_);
                  if(_loc7_ != null)
                  {
                     _loc5_ = _loc7_.getEventHandler();
                     if(_loc5_ != null)
                     {
                        _loc5_.update(_loc1_);
                     }
                  }
                  _loc4_--;
               }
            }
            _loc3_--;
         }
      }
      
      public function createRoomObject(param1:int, param2:String, param3:int) : IRoomObject
      {
         if(_container != null)
         {
            return _container.createRoomObject(_id,param1,param2,param3);
         }
         return null;
      }
      
      public function createObjectInternal(param1:int, param2:int, param3:String, param4:int) : IRoomObject
      {
         var _loc6_:IRoomObjectController = null;
         var _loc5_:IRoomObjectManager = createObjectManager(param4);
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.createObject(param1,param2,param3);
            if(_renderer != null)
            {
               _renderer.feedRoomObject(_loc6_);
            }
            return _loc6_;
         }
         return null;
      }
      
      public function getObject(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObject(param1);
         }
         return null;
      }
      
      public function getObjects(param1:int) : Array
      {
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         return !!_loc2_ ? _loc2_.getObjects() : [];
      }
      
      public function getObjectWithIndex(param1:int, param2:int) : IRoomObject
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObjectWithIndex(param1);
         }
         return null;
      }
      
      public function getObjectCount(param1:int) : int
      {
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         if(_loc2_ != null)
         {
            return _loc2_.getObjectCount();
         }
         return 0;
      }
      
      public function getObjectWithIndexAndType(param1:int, param2:String, param3:int) : IRoomObject
      {
         var _loc4_:IRoomObjectManager = getObjectManager(param3);
         if(_loc4_ != null)
         {
            return _loc4_.getObjectWithIndexAndType(param1,param2);
         }
         return null;
      }
      
      public function getObjectCountForType(param1:String, param2:int) : int
      {
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            return _loc3_.getObjectCountForType(param1);
         }
         return 0;
      }
      
      public function disposeObject(param1:int, param2:int) : Boolean
      {
         var _loc4_:IRoomObject = null;
         var _loc3_:IRoomObjectManager = getObjectManager(param2);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getObject(param1);
            if(_loc4_ != null)
            {
               _loc4_.tearDown();
               if(_renderer)
               {
                  _renderer.removeRoomObject(_loc4_);
               }
               return _loc3_.disposeObject(param1);
            }
         }
         return false;
      }
      
      public function disposeObjects(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:IRoomObjectController = null;
         var _loc3_:int = 0;
         var _loc2_:IRoomObjectManager = getObjectManager(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getObjectCount();
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc2_.getObjectWithIndex(_loc4_) as IRoomObjectController;
               if(_loc5_ != null)
               {
                  if(_renderer)
                  {
                     _renderer.removeRoomObject(_loc5_);
                  }
                  _loc5_.dispose();
               }
               _loc4_++;
            }
            _loc2_.reset();
         }
         return _loc3_;
      }
      
      public function setRenderer(param1:IRoomRendererBase) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:IRoomObjectController = null;
         if(param1 == _renderer)
         {
            return;
         }
         if(_renderer != null)
         {
            _renderer.dispose();
         }
         _renderer = param1;
         if(_renderer == null)
         {
            return;
         }
         _renderer.reset();
         var _loc5_:Array = getObjectManagerIds();
         _loc3_ = _loc5_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = int(_loc5_[_loc3_]);
            _loc2_ = getObjectCount(_loc6_);
            _loc4_ = _loc2_ - 1;
            while(_loc4_ >= 0)
            {
               _loc7_ = getObjectWithIndex(_loc4_,_loc6_) as IRoomObjectController;
               if(_loc7_ != null)
               {
                  _renderer.feedRoomObject(_loc7_);
               }
               _loc4_--;
            }
            _loc3_--;
         }
      }
      
      public function getRenderer() : IRoomRendererBase
      {
         return _renderer;
      }
      
      public function getObjectManagerIds() : Array
      {
         return _managers.getKeys();
      }
      
      protected function createObjectManager(param1:int) : IRoomObjectManager
      {
         var _loc3_:String = String(param1);
         if(_managers.getValue(_loc3_) != null)
         {
            return _managers.getValue(_loc3_) as IRoomObjectManager;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc2_:IRoomObjectManager = _container.createRoomObjectManager();
         if(_loc2_ != null)
         {
            _managers.add(_loc3_,_loc2_);
         }
         return _loc2_;
      }
      
      protected function getObjectManager(param1:int) : IRoomObjectManager
      {
         return _managers.getValue(String(param1)) as IRoomObjectManager;
      }
      
      protected function disposeObjectManager(param1:int) : Boolean
      {
         var _loc2_:IRoomObjectManager = null;
         var _loc3_:String = String(param1);
         disposeObjects(param1);
         if(_managers.getValue(_loc3_) != null)
         {
            _loc2_ = _managers.remove(_loc3_) as IRoomObjectManager;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            return true;
         }
         return false;
      }
      
      public function hasUninitializedObjects() : Boolean
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc2_ in _managers)
         {
            _loc1_ = _loc2_.getObjectCount();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(!_loc2_.getObjectWithIndex(_loc3_).isInitialized())
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
   }
}

