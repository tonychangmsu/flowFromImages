import numpy as np
import matplotlib.pyplot as plt
import itertools
import concurrent.futures
import os

def _count_file(fn):
    with open(fn, 'rb') as f:
        return _count_file_object(f)
    
def _count_file_object(f):
    # Note that this iterates on 'f'.
    # You *could* do 'return len(f.read())'
    # which would be faster but potentially memory 
    # inefficient and unrealistic in terms of this 
    # benchmark experiment. 
    total = 0
    for line in f:
        total += len(line)
    return total

def unzip_member_f3(zip_filepath, filename, dest):
    with open(zip_filepath, 'rb') as f:
        zf = zipfile.ZipFile(f)
        zf.extract(filename, dest)
    fn = os.path.join(dest, filename)
    return _count_file(fn)

def extract_data(fn, dest):
    with open(fn, 'rb') as f:
        zf = zipfile.ZipFile(f)
        futures = []
        with concurrent.futures.ProcessPoolExecutor() as executor:
            for member in zf.infolist():
                futures.append(
                    executor.submit(
                        unzip_member_f3,
                        fn,
                        member.filename,
                        dest,
                    )
                )
            total = 0
            for future in concurrent.futures.as_completed(futures):
                total += future.result()
    return total

def plot_confusion_matrix(cm, classes, normalize=False, outname='conf_mat.png', cmap=plt.cm.Blues):
    """
    This function prints and plots the confusion matrix.
    Normalization can be applied by setting `normalize=True`.
    """
    if normalize:
        cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        title = "Normalized confusion matrix"
        print(title)
    else:
        title = "Confusion matrix"
        print(title)

    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    cb=plt.colorbar()

    if normalize:
        cb.set_label('Percent')
    else:
        cb.set_label('$n$')
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes, rotation=45)
    plt.yticks(tick_marks, classes)

    fmt = '.3f' if normalize else 'd'
    thresh = cm.max() / 2.
    for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
        plt.text(j, i, format(cm[i, j], fmt), horizontalalignment="center",\
                color="white" if cm[i, j] > thresh else "black")

    plt.tight_layout()
    plt.ylabel('Measured label')
    plt.xlabel('Predicted label')

    #plt.savefig(outname, dpi=300, bbox_inches='tight', padding=False)

