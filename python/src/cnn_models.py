from keras import models, layers
from keras.layers.convolutional import Conv2D, MaxPooling2D
from keras.layers import Activation, BatchNormalization, Dropout, \
        Flatten, Dense, Concatenate, Input
from keras.layers.wrappers import TimeDistributed
from keras.layers.recurrent import LSTM, GRU
from src.dense_net import dense_stack
from keras import backend as K

K.set_image_data_format('channels_last')

def rmse(y_true, y_pred):
    return(K.sqrt(K.mean(K.square(y_pred - y_true))))

def det_coeff(y_true, y_pred):
    u = K.sum(K.square(y_true - y_pred))
    v = K.sum(K.square(y_true - K.mean(y_true)))
    return(K.ones_like(v) - (u / v))

def coeff_determination(y_true, y_pred):
    SS_res =  K.sum(K.square( y_true-y_pred ))
    SS_tot = K.sum(K.square( y_true - K.mean(y_true) ) )
    return ( 1 - SS_res/(SS_tot + K.epsilon()) )

def conv_block(x,f):
    x = Conv2D(f, (3,3), padding='same')(x)
    x = BatchNormalization()(x)
    x = Activation('relu')(x)   
    return(x)

def simple_cnn(input_shape, output_shape):
    input_layer = Input(shape=input_shape, name='input_layer')
    x = conv_block(input_layer,16)
    x = MaxPooling2D(pool_size=(2,2))(x)
    x = conv_block(x,32)
    x = MaxPooling2D(pool_size=(2,2))(x)
    x = BatchNormalization()(x)
    x = Flatten()(x)
    x = Dense(20)(x)
    output_layer = Dense(output_shape, activation='softmax', name='output_layer')(x)
    return(models.Model(inputs=input_layer, outputs=output_layer))

def dense_cnn(input_shape, n_dblocks, output_shape):
    input_layer = Input(shape=input_shape, name='input_layer')
    dense = dense_stack(input_layer, n_final_filter=256, \
            dropout=0.1, n_dblocks=n_dblocks)
    fc1 = Dense(512, name='fc1')(dense)
    fc2 = Dense(512, name='fc2')(fc1)
    output_layer = Dense(output_shape, activation='softmax', name='output_layer')(fc2)
    model = models.Model(inputs=input_layer, outputs=output_layer)
    return(model)


