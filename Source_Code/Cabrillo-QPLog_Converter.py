import tkinter
from tkinter import filedialog, scrolledtext

BANDS_ARRAY = ['1800','3500','7000','14000','21000','28000','50000','144000'];

root = tkinter.Tk()
root.title("Conversion de Cabrillo à QPLog, par VE2ZAZ/VA2IW")
root.geometry('{}x{}'.format(800, 400))
#root.withdraw()

text_area = scrolledtext.ScrolledText(root, wrap = tkinter.WORD, width = 475, height = 475, font = ("Courier", 12)) 
text_area.pack(fill=tkinter.BOTH, expand=True)#text_area.configure(state ='disabled') 

text_area.insert(tkinter.INSERT, '\nSelectionnez le(s) fichier(s) Cabrillo à convertir...\n')
files = filedialog.askopenfilenames(parent=root, title='Choose Cabrillo file(s) to convert', multiple=True, filetypes=[("All files", "*.*")])
files = root.tk.splitlist(files)
for filename in files:
    text_area.insert(tkinter.INSERT, '\nConversion de ' + filename + ':\n')
    print('Conversion de ' + filename + ':')
    source_file = open(filename,'r') 							  	# Open log file for reading
    result_filename = filename[:filename.rfind('.')] + ".qplog"   	# Removes extension in file name, then adds .qplog
    result_file = open(result_filename,'w')							# Open qplog file for writing. 
    
    # Create the qplog file
    for line in source_file:
        line_array = line.split('\n')								# removes the \n
        line_array = line_array[0].split(' ')						# Parse content of on Cabrillo line
        if line_array[0] == "QSO:":
            # Work on frequency
            freq = line_array[1]
            if not(freq in BANDS_ARRAY):							# special conversion must be made to convert non-standard frequencies (ex, 7052KHz) to standard frequencies (7000KHz)
                if (3500 <= int(freq) <= 4000): freq = '3500'
                elif (7000 <= int(freq) <= 7300): freq = '7000'
                elif (144 <= int(freq) <= 148): freq = '144000'
                else:
                    for i in range(0, len(BANDS_ARRAY) - 1):		# Other bands cause no confusion using the first two characters.
                        if freq[0:2] == BANDS_ARRAY[i][0:2]:
                            freq = BANDS_ARRAY[i]
                            break                        
            mode = line_array[2]
            if (mode == 'PH'): mode = 'SSB'							# QPLog program uses 'SSB'
            date_str = line_array[3]
            time_str = line_array[4]
            time_str = time_str[0:2] + ':' + time_str[2:4]
            home_call = line_array[5]
            home_rst = line_array[6]
            home_zone = line_array[7]
            dx_call = line_array[8]
            dx_rst = line_array[9]
            dx_zone = line_array[10]
            
            result_file.write(date_str + '_' + time_str + ',' + freq + ',' + mode + ','
                              + dx_call + ',' + dx_rst + ',' + dx_zone + ',' + 'QC' + ','+ home_zone +'\n')
    result_file.close()                 # Close it right away to erase all content.
    source_file.close()
    print('   Fichier ' + filename[:filename.rfind('.')] +'.qplog créé.')
    text_area.insert(tkinter.INSERT, '   Fichier ' + filename[:filename.rfind('.')] +'.qplog créé.\n')

    #Create the log config file
    with open(filename,'r') as f:		# Re-open Cabrillo source file 
        source_list = list(f)			# Load contents into large list of lines
    result_filename = filename[:filename.rfind('.')] + ".qplog_cfg"
    result_file = open(result_filename,'w')
    for line in source_list:
        line_array = line.split('\n')			# removes the \n
        line_array = line_array[0].split(' ')			# removes the \n
        if line_array[0] == 'CONTEST:':
            if (line_array[1] == 'QC-QSO-PARTY'):
                result_file.write('0\n')		# QCQP only
            elif (line_array[1] == 'ON-QSO-PARTY'): result_file.write('1\n')		# QCQP only
    for line in source_list:
        line_array = line.split(' ')			# removes the \n
        if line_array[0] == 'CATEGORY-OPERATOR:': result_file.write(line_array[1])        # includes the \n
    for line in source_list:
        line_array = line.split(' ')			# removes the \n
        if line_array[0] == 'CATEGORY-POWER:': result_file.write(line_array[1])        # includes the \n
    for line in source_list:
        line_array = line.split(' ')			# removes the \n
        if line_array[0] == 'CATEGORY-STATION:': result_file.write(line_array[1])        # includes the \n
    for line in source_list:
        line_array = line.split(' ')			# removes the \n
        if line_array[0] == 'CATEGORY-MODE:':
            if (line_array[1] == 'SSB\n'): result_file.write('SSB / FM\n')
            else: result_file.write(line_array[1])
    for line in source_list:
        line_array = line.split(' ')			# removes the \n
        if line_array[0] == 'CALLSIGN:': result_file.write(line_array[1])        # includes the \n
    result_file.write('---\n')    # Zone
    result_file.write('---\n')    # Location
    # The following lines can be left empty but \n required
    result_file.write('\n')   
    result_file.write('\n')   
    result_file.write('\n')   
    result_file.write('\n')   

    result_file.close()                 # Close it right away to erase all content.
    source_file.close()
    print('   Fichier ' + filename[:filename.rfind('.')] +'.qplog_cfg créé.\n')
    text_area.insert(tkinter.INSERT, '   Fichier ' + filename[:filename.rfind('.')] +'.qplog_cfg créé.\n')

text_area.insert(tkinter.INSERT, '\nConversions complétées.')
text_area.config(state="disabled")
root.update()
print ("Conversions complétées")
#root.destroy() 							# Ends the program
root.mainloop()
