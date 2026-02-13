export const pdf = async (pdf) => {
    if(process.client){
        const html2pdf = (await import('html2pdf.js')).default;
        html2pdf().from(pdf).save()
    }
}